require 'rest_client'
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
            html = %Q(<p>Welcome <%= @user.email %>!</p><p>You can confirm your account email through the link below:</p><p><%= link_to 'Confirm my account', finish_user_info_for_email_register_frontend_users_mine_index(@user) %></p>)
            # MailJob.perform_later(@user.email, '注册验证', html)
            send_mail(@user.email, '注册验证', html)

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

      def send_mail(to, subject, html)
        response = RestClient.post Settings.mail.url,{
          api_user: Settings.mail.api_user,
          api_key: Settings.mail.api_key,
          from: Settings.mail.from,
          fromname: "搜医搜",
          to: to,
          subject: subject,
          html: html
        }

        puts response
      end

    end
  end
end
