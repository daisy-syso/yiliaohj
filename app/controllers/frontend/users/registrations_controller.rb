module Frontend
  module Users
    class RegistrationsController < FrontendController
      def email_new
        @user = User.new
      end

      def telephone_new
        @user = User.new
      end

      def email
        # debugger
        @user = User.new user_email_params
        
        if params[:user][:password] == params[:user][:password_confirmation]
          if @user.save
            redirect_to sent_successful_frontend_users_registrations_path
          else
            render :email_new
          end
        else
          render :email_new
        end
      end

      def telephone
        @user = User.where(telephone: params[:telephone]).first
        if @user.present?
          render :telephone_new
        end

        @user = User.new user_telephone_params

        telephone_code = $redis_sms.get "register_#{params[:user][:telephone]}_code"

        puts telephone_code

        if telephone_code != params[:code]
          render :telephone_new
        else
          render :person
        end
      end

      def check_register_telephone
        user = User.where(telephone: params[:telephone]).first

        results = if user.present?
                    {status: 422, message: '号码已经被注册'}
                  else
                    {status: 200, message: 'OK'}
                  end
        render json: results
      end

      def check_register_email
        user = User.where(email: params[:email]).first

        results = if user.present?
                    {status: 422, message: '邮箱已经被注册'}
                  else
                    {status: 200, message: 'OK'}
                  end
        render json: results
      end

      private

      def user_telephone_params
        params.require(:user).permit(:telephone)
      end

      def user_email_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

    end
  end
end
