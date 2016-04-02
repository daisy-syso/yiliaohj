class Frontend::CategoriesController < FrontendController
  # before_action :set_comment_origin, only: [:index, :new, :create]
  # before_action :auth_check, only: [:new, :create]


  def index
    # @comments = @comment_origin.comments.includes(:user).desc(:created_at).page(params[:page]).per(params[:per])

    @hospital_categories = HospitalCategory.includes(:children).where(parent_id: nil)

    # @disease_categories = 
  end

end
