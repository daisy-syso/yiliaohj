class Frontend::CategoriesController < FrontendController
  def index
    @hospital_categories = HospitalCategory.includes(:children).where(parent_id: nil)

    @disease_categories = Department.includes(:children).where(parent_id: nil)

    @doctor_categories = Department.includes(:children).where(parent_id: nil)

    # ["男科", "整形", "体检", "中医", "妇幼", "牙科", "综合", "其它"]
    @buffets =
    [
      {
        name: '精准男科',
        link: '/buffets?hospital_category_parent_name=男科'
      },
      {
        name: '精准整形',
        link: '/buffets?hospital_category_parent_name=整形'
      },
      {
        name: '精准体检',
        link: '/buffets?hospital_category_parent_name=体检'
      },
      {
        name: '精准中医',
        link: '/buffets?hospital_category_parent_name=中医'
      },
      {
        name: '精准妇幼',
        link: '/buffets?hospital_category_parent_name=妇幼'
      },
      {
        name: '精准牙科',
        link: '/buffets?hospital_category_parent_name=牙科'
      },
      {
        name: '精准体检',
        link: '/examinations'
      }
    ]
  end
end
