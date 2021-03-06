require 'rest_client'
class MailJob < ActiveJob::Base
  queue_as :mail

  def perform(to, subject, html)
    logger = Logger.new(Rails.root.join(Settings.mail.log))

    response = RestClient.post Settings.mail.url, api_user: Settings.mail.api_user,
                                                  api_key: Settings.mail.api_key,
                                                  from: Settings.mail.from,
                                                  fromname: "搜医搜",
                                                  to: to,
                                                  subject: subject,
                                                  html: html

    logger.info "#{to}--#{response.body}--#{Time.zone.now}"
  end
end

# to = '651019063@qq.com'
# subject = 'test'
# html = %Q(<!doctype html> <html style="background:#f6f7f2"> <head> <style> html, body { margin: 0; padding: 0; } </style> </head> <body> <center> <table> <tbody> <tr> <td> <table border="0" cellpadding="0" cellspacing="0" width="600px"> <tbody> <tr> <td> <table style="background:url(http://7xi9bi.com1.z0.glb.clouddn.com/35069/2015/07/20/a9179f3bf9714c08b6b8e02c2296aa42.jpg) no-repeat top center;width:100%;font-size:14px;"> <tbody> <tr> <td align="center"> <table border="0" cellpadding="0" cellspacing="0" style="background:url(http://7xi9bi.com1.z0.glb.clouddn.com/35069/2015/07/20/e8b87c314d4c4b9d9dbbe63c6c2b0632.jpg) no-repeat center center;margin-top:53px;width:500px;height:449px;box-shadow: 3px 3px 3px #eee"> <tbody> <tr> <td colspan="2" align="center" valign="top"> <div style="margin-top:115px;color:#1271be;line-height:1.5;"> XXX，欢迎加入我们! <br>为了保证您正常使用我们的功能，请激活账号。 </div> <div style="margin-top:60px"> <a href="%url%" style="text-decoration:none;display:inline-block;color:#fff;width:144px;height:38px;line-height:38px;background:url(http://7xi9bi.com1.z0.glb.clouddn.com/35069/2015/07/20/2f7e0a9789e642eeb3ccdcfcbf759086.jpg) no-repeat center;">立即激活</a> </div> </td> </tr> <tr> <td valign="bottom"> <table border="0" cellpadding="0" cellspacing="0" width="214px" style="background:url(http://7xi9bi.com1.z0.glb.clouddn.com/35069/2015/07/20/0f5667bc43d94ae49fed78ad3e412e14.png) #f5f5f5 no-repeat top right"> <tbody> <tr> <td valign="middle" align="center" height="130px"> <div style="width:148px;color:#fff;font-size:12px;text-align:left;padding-left:10px;line-height:2;"> 如果以上按钮无法打开， <br>请把右侧的链接复制到浏览 <br>器地址栏中打开： </div> </td> </tr> </tbody> </table> </td> <td valign="bottom"> <table border="0" cellpadding="0" cellspacing="0" width="287px" style="background:#f5f5f5"> <tbody> <tr> <td valign="middle" align="center" height="130px"> <p style="padding: 0 20px;word-wrap:break-word;word-break:break-word;line-height:1.75">23689065432345678</p> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </center> </body> </html>)
# MailJob.perform_later(to, subject, html)

# html = %Q(<p>Welcome <%= @email %>!</p><p>You can confirm your account email through the link below:</p><p><%= link_to 'Confirm my account', confirmation_url(@resource, confirmation_token: @token) %></p>)
