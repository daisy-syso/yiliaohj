module Frontend
  module Users
    class PasswordsController < FrontendController
      before_action :get_user, only: [:edit, :update, :index]
      def new
        redirect_to new_frontend_users_session_path unless @user 
      end

      def edit
        
      end

      def telephone_new
        @user = User.new
      end

      def telephone
        @user = User.where(telephone: params[:user][:telephone]).first
        if @user.blank?
          flash[:notice] = '号码不存在存在'
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

    end
  end
end