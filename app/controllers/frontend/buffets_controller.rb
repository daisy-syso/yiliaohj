class Frontend::BuffetsController < FrontendController
  before_action :get_hospital_categories, only: [:index]

  def index
    if params[:hospital_category].present?
      hospital_category = HospitalCategory.where(name: params[:hospital_category]).first

      @buffets = hospital_category.buffets.includes(:comments).includes(:commodities).page(params[:page]).per(params[:per])

    else
      @buffets = Buffet.includes(:comments).includes(:commodities)

      @buffets = @buffets.where(:group_buying_name.in => @hospital_categories.pluck(:name)).page(params[:page]).per(params[:per])
    end
  end

  def show
    @buffet = Buffet.find(params[:id])

    @comment = @buffet.comments.desc(:created_at).first
  end

  private

  def get_hospital_categories
    @hospital_category_parent_name = params[:hospital_category_parent_name]
    if @hospital_category_parent_name.blank?
      redirect_to '/'
    end
    hospital_category = HospitalCategory.where(name: @hospital_category_parent_name).first

    @hospital_categories = hospital_category.children
  end
end
