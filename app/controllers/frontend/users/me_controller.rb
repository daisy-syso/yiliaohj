module Frontend
  module Users
    class MeController < FrontendController
      before_action :get_user, only: [:edit, :update, :index]
      def index
        redirect_to new_frontend_users_session_path unless @user 
      end

      def edit
        
      end

      def update
        @user.update user_params

        redirect_to frontend_users_me_index_path
      end

      private

      def user_params
        params.require(:user).permit(:email, :telephone, :nickname, :avatar)
      end

      def get_user
        user_id = session[:user_id]
        @user = User.where(id: user_id).first
      end
    end
  end
end