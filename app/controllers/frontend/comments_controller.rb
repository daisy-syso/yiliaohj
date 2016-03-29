class Frontend::CommentsController < FrontendController
  before_action :set_comment_origin, only: [:index, :new, :create]
  before_action :auth_check, only: [:new, :create]

  include ApplicationHelper
  def index
    @comments = @comment_origin.comments.includes(:user).desc(:created_at).page(params[:page]).per(params[:per])
  end

  def new
    @comment = @comment_origin.comments.new
  end

  def create
    comment = @comment_origin.comments.new comment_params
    comment.user = @current_user
    if comment.save
      @comment_origin.category_star!
      redirect_to "/#{@comment_origin.class.to_s.underscore.pluralize}/#{@comment_origin.id.to_s}"
    end
  end

  private

  def set_comment_origin
    @comment_origin = get_comment_origin.find(get_comment_origin_id)
  end

  def comment_params
    params.require(:comment).permit(:content, :rating)
  end
end
