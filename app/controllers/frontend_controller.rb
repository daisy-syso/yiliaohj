class FrontendController < ApplicationController
  protect_from_forgery with: :null_session, if: proc { |c| c.request.format == 'application/json' }

  layout 'frontend/application'

  def auth_check
    @current_user = User.where(id: session[:user_id]).first
    redirect_to new_frontend_users_session_path if @current_user.blank?
  end
end
