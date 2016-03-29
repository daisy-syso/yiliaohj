module Frontend
  module Users
    class SmsController < FrontendController
      def create
        telephone = params[:telephone]
        event = params[:event]

        user = User.where(telephone: telephone).first

        results = if !%w(register forget_password).include?(event)
                    { status: 422, message: 'event 参数值不正确' }
                  elsif event == 'forget_password' && user.nil?
                    { status: 422, message: '号码还未被注册' }
                  elsif event == 'register' && user
                    { status: 422, message: '号码已经被注册' }
                  elsif telephone.size != 11
                    { status: 422, message: '号码不合法' }
                  else
                    SmsJob.perform_later(telephone, event)

                    { status: 200, message: 'OK' }
                  end
        render json: results
      end
    end
  end
end
