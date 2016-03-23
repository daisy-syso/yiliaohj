# frozen_string_literal: true
# 短信
class SmsJob < ActiveJob::Base
  queue_as :sms

  def perform(telephone, event)
    telephone_code = Utils::Random.digital_code(4)

    $redis_sms.set "#{event}_#{telephone}_code", telephone_code

    $redis_sms.expire("#{event}_#{telephone}_code", 1800)

    logger = Logger.new(Rails.root.join(Settings.sms.log))

    timestamp = Time.zone.now.strftime('%F %T')

    sign_params = {
      method: Settings.sms.method_str,
      app_key: Settings.sms.appkey,
      timestamp: timestamp,
      v: '2.0',
      sign_method: 'md5',
      sms_type: 'normal',
      # sms_free_sign_name: '医了得',
      sms_free_sign_name: '身份验证',
      rec_num: telephone,
      format: 'json',
      simplify: true,
      sms_template_code: 'SMS_6440281',
      sms_param: "{code: \"#{telephone_code}\", product: \"医了得\"}"
    }

    params = sign_params.merge(sign: sign(sign_params))

    res = Net::HTTP.post_form(URI.parse(Settings.sms.url), params)

    result = Oj.load(res.body)
    logger.info "#{telephone}--#{telephone_code}---#{result}"
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
