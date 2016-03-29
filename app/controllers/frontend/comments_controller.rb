class Frontend::CommentsController < FrontendController
  before_action :set_hospital, only: [:index, :new, :create]
  before_action :auth_check, only: [:new, :create]

  def index
    @comments = @hospital.comments.desc(:created_at).page(params[:page]).per(params[:per])
  end

  def new
    @comment = @hospital.comments.new
  end

  def create
    comment = @hospital.comments.new comment_params
    comment.user = @current_user
    if comment.save
      @hospital.category_star!
      redirect_to frontend_hospital_path(@hospital)
    end
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:hospital_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :rating)
  end
end
