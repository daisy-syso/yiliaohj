class Frontend::BuffetsController < FrontendController

  def index
    hospital_category_parent_name = params[:hospital_category_parent_name]

    hospital_category = HospitalCategory.where(name: hospital_category_parent_name).first

    @hospital_categories = hospital_category.children

    @hospital_category_names = @hospital_categories.pluck(:name)

    @buffets = Buffet.where(group_buying_name: @hospital_category_names).page(params[:page]).per(params[:per])
  end

  def show
    
  end
end
