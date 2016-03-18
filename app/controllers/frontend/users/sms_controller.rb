module Frontend
  module Users
    class SmsController < FrontendController
      def create
        telephone = params[:telephone]
        event = params[:event]

        user = User.where(telephone: telephone).first

        results = if !%w(register forget_password).include?(event)
                    {status: 422, message: 'event 参数值不正确'}
                  elsif event == 'forget_password' && user.nil?
                    {status: 422, message: '号码还未被注册'}
                  elsif event == 'register' && user
                    {status: 422, message: '号码已经被注册'}
                  elsif telephone.size != 11
                    {status: 422, message: '号码不合法'}
                  else
                    telephone_code = Utils::Random.digital_code(4)

                    $redis_sms.set "#{event}_#{params[:telephone]}_code", telephone_code

                    $redis_sms.expire("#{event}_#{params[:telephone]}_code", 1800)

                    SmsJob.perform_later(params[:telephone], telephone_code)

                    {status: 200, message: 'OK'}
                  end
        render json: results
      end
    end
  end
end
