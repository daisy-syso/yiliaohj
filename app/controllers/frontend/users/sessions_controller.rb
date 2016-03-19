module Frontend
  module Users
    class SessionsController < FrontendController
      
      def new
        @user = User.new
      end

      def create
        account = params[:user][:account]
        password = params[:user][:password]

        user = User.or(telephone: account).or(email: account).first
        if user && user.password == password
          session[:account_id] = user.id.to_s
          redirect_to '/'
        else
          redirect_to new_frontend_users_session_path, notice: '登录失败'
        end
      end
    end
  end
end
