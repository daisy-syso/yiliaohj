module Frontend
  module Users
    class ConfirmationsController < FrontendController
      before_action :set_user, only: [:show, :reset_email_password]

      def show
        if @user.reset_password_token == params[:token]
          session[:user_id] = @user.id.to_s
          @user.reset_password_token = nil
          @user.save
          redirect_to edit_frontend_users_me_path(@user)
        else
          redirect_to new_frontend_users_session_path
        end
      end

      def reset_email_password
        if @user.reset_token == params[:token]
          session[:user_id] = @user.id.to_s
          @user.reset_token = nil
          @user.save
          redirect_to email_edit_frontend_users_passwords_url
        else
          redirect_to new_frontend_users_session_path
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
