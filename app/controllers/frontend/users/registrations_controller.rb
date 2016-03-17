module Frontend
  module Users
    class RegistrationsController < FrontendController
      def new
        
      end

      def email
        
      end

      def telephone
        
      end

      # def create
      #   case params[:register_type]
      #   when 'telephone'
      #     telephone_code = $redis_sms.get "#{params.user.telephone}_code"

      #     user = User.where(telephone: params.user.telephone).first
      #     if telephone_code != params.user.code
      #       raise Errors::CustomMessageError.new '验证码无效', :unprocessable_entity
      #     end

      #     user = User.new user_telephone_params
      #     if user.save
      #       redirect_to new_frontend_users_session_path
      #     end
      #   when 'email'
      #     user = User.new user_email_params
      #     if user.save
      #       redirect_to new_frontend_users_session_path
      #     end
      #   end

      #   user = User.new new_user_params
      # end

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
        params.require(:user_telephone).permit(:telephone, :password, :code)
      end

      def user_email_params
        params.require(:user_email).permit(:email, :password)
      end

    end
  end
end
