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
        @user = User.where(email: params[:user][:email]).first
        if @user.present?
          flash[:notice] = '邮箱已经被注册'
          render :email_new
        else
          @user = User.new user_email_params

          if params[:user][:password] == params[:user][:password_confirmation]
            if @user.save
              # MailJob.perform_later(@user.email, '注册验证', html)
              token = Utils::Random.digital_code(20)
              url = frontend_users_confirmation_url(@user, token: token)
              send_mail(@user.email, '邮箱验证', url)
              @user.reset_password_token = token
              @user.save

              redirect_to sent_successful_frontend_users_registrations_path
            else
              render :email_new
            end
          else
            flash[:notice] = '两次输入密码不一样'
            render :email_new
          end
        end
      end

      def telephone
        @user = User.where(telephone: params[:user][:telephone]).first
        if @user.present?
          flash[:notice] = '号码已经存在'
          render :telephone_new
        else
          @user = User.new user_telephone_params
          telephone_code = $redis_sms.get "register_#{params[:user][:telephone]}_code"
          if telephone_code != params[:code]
            flash[:notice] = '验证码错误'
            render :telephone_new
          else
            if @user.save
              $redis_sms.del "register_#{params[:user][:telephone]}_code"
              session[:user_id] = @user.id.to_s
              redirect_to edit_frontend_users_me_path(@user)
            else
              render :telephone_new
            end
          end
        end
      end

      def update
      end

      def check_register_telephone
        user = User.where(telephone: params[:telephone]).first

        results = if user.present?
                    { status: 422, message: '号码已经被注册' }
                  else
                    { status: 200, message: 'OK' }
                  end
        render json: results
      end

      def check_register_email
        user = User.where(email: params[:email]).first

        results = if user.present?
                    { status: 422, message: '邮箱已经被注册' }
                  else
                    { status: 200, message: 'OK' }
                  end
        render json: results
      end

      private

      def user_telephone_params
        params.require(:user).permit(:telephone, :password)
      end

      def user_email_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      def send_mail(to, subject, url)
        vars = JSON.dump('to' => [to], 'sub' => { '%url%' => [url] })
        response = RestClient.post Settings.mail.url, api_user: Settings.mail.api_user,
                                                      api_key: Settings.mail.api_key,
                                                      from: Settings.mail.from,
                                                      fromname: "搜医搜",
                                                      substitution_vars: vars,
                                                      template_invoke_name: 'test_template_active',
                                                      subject: subject,
                                                      resp_email_id: 'true'
        puts 'zzzzzzz'
        puts response
      end
    end
  end
end

# https://sendcloud.sohu.com/apiv2/template/add?apiUser=yiliaohj_mail&apiKey=qMgh602Vx1zeL4kf&invokeName=email_confirmation&name=%E9%82%AE%E7%AE%B1%E9%AA%8C%E8%AF%81&subject=%E9%82%AE%E7%AE%B1%E9%AA%8C%E8%AF%81&html=%3Cp%3E%E4%BD%A0%E5%A5%BD%20%25email%25!%3C%2Fp%3E%3Cp%3E%E6%AC%A2%E8%BF%8E%E6%B3%A8%E5%86%8C%E5%8C%BB%E4%B8%80%E5%BE%97%3C%2Fp%3E%3Ca%20href%3D'%25url%25'%3E%E7%82%B9%E5%87%BB%E9%AA%8C%E8%AF%81%E6%82%A8%E7%9A%84%E9%82%AE%E4%BB%B6%3C%2Fa%3E&templateType=1
