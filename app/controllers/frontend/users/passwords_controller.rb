module Frontend
  module Users
    class PasswordsController < FrontendController
      before_action :get_user, only: [:edit, :update, :index]
      def new
        redirect_to new_frontend_users_session_path unless @user 
      end

      def edit
        
      end

      def email_new
        @user = User.new
      end

      def email_edit
        @user = User.find(params[:id])
      end

      def email
        @user = User.where(email: params[:user][:email]).first
        if @user.blank?
          flash[:notice] = '邮箱不存在'
          render :email_new
        else
          reset_token = Utils::Random.digital_code(20)
          @user.reset_token = reset_token
          url = reset_email_password_frontend_users_confirmation_url(@user, token: reset_token)
          send_mail(@user.email, '邮箱验证', url)

          @user.save
          redirect_to sent_successful_frontend_users_registrations_path
        end
      end

      def telephone_new
        @user = User.new
      end

      def telephone
        @user = User.where(telephone: params[:user][:telephone]).first
        if @user.blank?
          flash[:notice] = '号码不存在'
          render :telephone_new
        else
          telephone_code = $redis_sms.get "forget_password_#{params[:user][:telephone]}_code"
          if telephone_code != params[:code]
            flash[:notice] = '验证码错误'
            render :telephone_new
          else
            @user.password = params[:user][:password]
            if @user.save
              $redis_sms.del "forget_password_#{params[:user][:telephone]}_code"
              session[:user_id] = @user.id.to_s
              redirect_to frontend_users_me_index_path
            else
              render :telephone_new
            end
          end
        end
      end

      def send_mail(to, subject, url)
        vars = JSON.dump({"to" => [to], "sub" => { "%url%" => [url]} })
        response = RestClient.post Settings.mail.url,{
          api_user: Settings.mail.api_user,
          api_key: Settings.mail.api_key,
          from: Settings.mail.from,
          fromname: "搜医搜",
          substitution_vars: vars,
          template_invoke_name: 'test_template_active',
          subject: subject,
          resp_email_id: 'true'
        }
        puts "zzzzzzz"
        puts response
      end
    end
  end
end