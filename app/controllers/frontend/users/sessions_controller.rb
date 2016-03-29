module Frontend
  module Users
    class SessionsController < FrontendController
      def new
        @user = User.new
      end

      def create
        account = params[:user][:email]
        password = params[:user][:password]
        user = User.or(telephone: account).or(email: account).first
        if user && user.valid_password?(password) && user.reset_token.blank?
          if user.reset_token.present?
            redirect_to new_frontend_users_session_path, notice: '邮箱未验证'
          else
            session[:user_id] = user.id.to_s
            redirect_to frontend_users_me_index_path
          end
        else
          redirect_to new_frontend_users_session_path, notice: '登录失败'
        end
      end

      def destroy
        session[:user_id] = nil
        redirect_to new_frontend_users_session_path
      end
    end
  end
end
