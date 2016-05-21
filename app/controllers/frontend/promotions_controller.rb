class Frontend::PromotionsController < FrontendController

  def index
    group_buying_name = []

    @hospital_categories = HospitalCategory.includes(:children).where(:name.in => %w(整形 牙科 妇幼 男科 中医))
    @hospital_categories.each do |hospital_category|
      group_buying_name << hospital_category.children.pluck(:name)
    end

    group_buying_name = group_buying_name.flatten

    @buffets = Buffet
                .includes(:comments)
                .includes(:commodities)
                .where(:group_buying_name.in => group_buying_name)
                .desc(:created_at)
                .page(params[:page])
                .per(params[:per])

  end

  def show
    @buffet = Buffet.find(params[:id])

    @comment = @buffet.comments.desc(:created_at).first
  end
end
