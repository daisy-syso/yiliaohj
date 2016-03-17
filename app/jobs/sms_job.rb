# frozen_string_literal: true
class SmsJob < ActiveJob::Base
  queue_as :sms

  def perform(phone, telephone_code)
    logger = Logger.new(Rails.root.join(Settings.sms.log))

    timestamp = Time.zone.now.strftime('%F %T')

    sign_params = {
      method: Settings.sms.method_str,
      app_key: Settings.sms.appkey,
      timestamp: timestamp,
      v: '2.0',
      sign_method: 'md5',
      sms_type: 'normal',
      sms_free_sign_name: '身份验证',
      rec_num: phone,
      format: 'json',
      simplify: true,
      sms_template_code: 'SMS_5375100',
      sms_param: "{product: 'Class Mart', code: \"#{telephone_code}\"}"
    }

    params = sign_params.merge(sign: sign(sign_params))

    res = Net::HTTP.post_form(URI.parse(Settings.sms.url), params)
    logger.info "#{phone}--#{telephone_code}---#{Oj.load(res.body)}"

    result = Oj.load(res.body)['result']
    logger.info "#{phone}--#{telephone_code}---#{result}"
  end

  private

  def sign(params)
    Digest::MD5.hexdigest(wrap_with_secret(sorted_option_string(params))).upcase
  end

  def wrap_with_secret(s)
    "#{Settings.sms.appsecret}#{s}#{Settings.sms.appsecret}"
  end

  def sorted_option_string(options)
    options.map { |k, v| "#{k}#{v}" }.sort.join
  end
end
