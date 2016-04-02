class Frontend::CategoriesController < FrontendController
  
  def index
    @hospital_categories = HospitalCategory.includes(:children).where(parent_id: nil)

    # 000000000000000000000000   数据库bugs 暂时先这样写
    @disease_categories = Department.includes(:children).where(parent_id: '000000000000000000000000')

    @doctor_categories = Department.includes(:children).where(parent_id: '000000000000000000000000')
  end

end
