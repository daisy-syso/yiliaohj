class Frontend::BuffetsController < FrontendController
  before_action :set_hospital_category, only: [:index]

  def index
    # hospital_category 男科 妇科
    # group_buying_name  ITI种植体

    name = params[:name]
    hospital_category = HospitalCategory.where(name: name).first

    @hospital_categories = hospital_category.children

    @hospital_category_ids = @hospital_categories.pluck(:id)

    group_buyings = GroupBuying.where(hospital_category_id: @hospital_category_ids)

    @buffets = Buffet.all

    # group_buying_name  ITI种植体

    if params[:group_buying_id].present?
      group_buying = GroupBuying.where(id: params[:group_buying_id]).first
      @buffets = group_buying.buffets.page(params[:page]).per(params[:per])
    end
  end

  def show
    
  end

  private

  def set_hospital_category
    @hospital_category = HospitalCategory.find(params[:hospital_category_id])
  end
end
