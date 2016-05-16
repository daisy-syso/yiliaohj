class Frontend::CommentsController < FrontendController
  before_action :set_comment_origin, only: [:index, :new, :create, :get_more_comments]
  before_action :auth_check, only: [:new, :create]

  include ApplicationHelper
  def index
    @comments = @comment_origin.comments.includes(:user).desc(:created_at).page(params[:page]).per(2)
  end

  def get_more_comments
    @comments = @comment_origin.comments.includes(:user).desc(:created_at).page(params[:page]).per(2)
    html = ''
    @comments.each do |comment|
      html += %(<li class="comment-item">
        <div class="user-info">
          <img src="#{comment.user.try(:avatar)}" width="60px">
          <div class="comment-user-name">#{comment.user.try(:nickname)}</div>
          <div class="comment-time">#{comment.created_at.strftime('%F')}</div>
        </div>
        <div class="comment-rate pull-right">
          #{get_star_html(comment)}
        </div>
        <div class="comment-content">#{comment.content}</div>
      </li>)
    end
    render text: html
  end

  def get_star_html(comment)
    html = ''
    comment.rating.times do |_s|
      html += '<img class="star" src="/assets/static_pages/icon_star_selected-2aee1bdfec73bf558c370762c0839431f944bf2b23e8b847a51c4be98a680c88.png" alt="Icon star selected 2aee1bdfec73bf558c370762c0839431f944bf2b23e8b847a51c4be98a680c88">'
    end
    html
  end

  def new
    @comment = @comment_origin.comments.new
  end

  def create
    comment = @comment_origin.comments.new comment_params
    comment.user = @current_user
    if comment.save
      @comment_origin.category_star!
      redirect_to "/#{@comment_origin.class.to_s.underscore.pluralize}/#{@comment_origin.id}"
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
