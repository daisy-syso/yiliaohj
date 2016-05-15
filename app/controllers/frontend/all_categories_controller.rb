class Frontend::AllCategoriesController < FrontendController
  def index
    words = params[:key]

    case words
    when 'hospitals'
      @hospital_categories = HospitalCategory.where(parent_id: nil).includes(:children)

      arr = []
      @hospital_categories.each do |c|
        arr << {
          category_id: c.id.to_s,
          category_name: c.name,
          has_next: true
        }
      end

      render json: arr.to_json
    end
  end
end
