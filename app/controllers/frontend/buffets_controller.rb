class Frontend::BuffetsController < FrontendController
  before_action :get_hospital_categories, only: [:index]

  def index
    @buffets = Buffet.includes(:hospital).includes(:comments).includes(:commodities)

    @buffets = @buffets.where(:group_buying_name.in => @hospital_categories.pluck(:name))

    if params[:group_buying_name].present?
      @buffets = @buffets.where(group_buying_name: params[:group_buying_name])
    end

    if params[:sort_type].present?
      case params[:sort_type]
      when 'new'
        # 最近发布
        @buffets = @buffets.desc(:updated_at)
      when 'star'
        # 评价最好
        @buffets = @buffets.desc(:star)
      when 'click_count'
        # 人气最高
        @buffets = @buffets.desc(:click_count)
      end
    end

    @buffets = @buffets.page(params[:page]).per(params[:per])
  end

  def show
    @buffet = Buffet.find(params[:id])

    @buffet.visit!

    @comment = @buffet.comments.desc(:created_at).first
  end

  private

  def get_hospital_categories
    @hospital_category_parent_name = params[:hospital_category_parent_name]
    redirect_to '/' if @hospital_category_parent_name.blank?
    hospital_category = HospitalCategory.where(name: @hospital_category_parent_name).first

    @hospital_categories = hospital_category.children
  end
end
