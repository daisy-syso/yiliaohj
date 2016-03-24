require 'rest_client'
# # http://sendcloud.sohu.com/webapi/template.get.json?api_user=yiliaohj_mail&api_key=qMgh602Vx1zeL4kf

# curl -d 'api_user=yiliaohj_mail&api_key=qMgh602Vx1zeL4kf&invoke_name=testtemplate&name=test&html=<p>add new template</p>&subject=test_subject&email_type=1' http://sendcloud.sohu.com/webapi/template.add.json

# to = '651019063@qq.com'
# subject = 'test'
# z = 'davedave'
# html = %Q(<!doctype html> <html style="background:#f6f7f2"> <head> <style> html, body { margin: 0; padding: 0; } </style> </head> <body> <center> <table> <tbody> <tr> <td> <table border="0" cellpadding="0" cellspacing="0" width="600px"> <tbody> <tr> <td> <table style="background:url(http://7xi9bi.com1.z0.glb.clouddn.com/35069/2015/07/20/a9179f3bf9714c08b6b8e02c2296aa42.jpg) no-repeat top center;width:100%;font-size:14px;"> <tbody> <tr> <td align="center"> <table border="0" cellpadding="0" cellspacing="0" style="background:url(http://7xi9bi.com1.z0.glb.clouddn.com/35069/2015/07/20/e8b87c314d4c4b9d9dbbe63c6c2b0632.jpg) no-repeat center center;margin-top:53px;width:500px;height:449px;box-shadow: 3px 3px 3px #eee"> <tbody> <tr> <td colspan="2" align="center" valign="top"> <div style="margin-top:115px;color:#1271be;line-height:1.5;"> XXX，欢迎加入我们! <br>为了保证您正常使用我们的功能，请激活账号。 </div> <div style="margin-top:60px"> <a href="%url%" style="text-decoration:none;display:inline-block;color:#fff;width:144px;height:38px;line-height:38px;background:url(http://7xi9bi.com1.z0.glb.clouddn.com/35069/2015/07/20/2f7e0a9789e642eeb3ccdcfcbf759086.jpg) no-repeat center;">立即激活</a> </div> </td> </tr> <tr> <td valign="bottom"> <table border="0" cellpadding="0" cellspacing="0" width="214px" style="background:url(http://7xi9bi.com1.z0.glb.clouddn.com/35069/2015/07/20/0f5667bc43d94ae49fed78ad3e412e14.png) #f5f5f5 no-repeat top right"> <tbody> <tr> <td valign="middle" align="center" height="130px"> <div style="width:148px;color:#fff;font-size:12px;text-align:left;padding-left:10px;line-height:2;"> 如果以上按钮无法打开， <br>请把右侧的链接复制到浏览 <br>器地址栏中打开： </div> </td> </tr> </tbody> </table> </td> <td valign="bottom"> <table border="0" cellpadding="0" cellspacing="0" width="287px" style="background:#f5f5f5"> <tbody> <tr> <td valign="middle" align="center" height="130px"> <p style="padding: 0 20px;word-wrap:break-word;word-break:break-word;line-height:1.75">#{z}</p> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </center> </body> </html>)



# response = RestClient.post Settings.mail.url, {
#       api_user: Settings.mail.api_user,
#       api_key: Settings.mail.api_key,
#       from: Settings.mail.from,
#       fromname: "搜医搜",
#       to: to,
#       subject: subject,
#       html: html
#     }
    
#     puts response.code
#     puts response.body
# '<p>你好 %email%!</p><p>欢迎注册医一得</p><a href="%url%">点击验证您的邮件</a>'
# html = '<p>你好 651019063@qq.com!</p><p>欢迎注册医一得</p><a href="http://www.baidu.com">点击验证您的邮件</a>'
# html = "<p>你好 %email%!</p><p>欢迎注册医一得</p><a href='%url%'>点击验证您的邮件</a>"
# html = '<p>add aaa new template</p>'
# html = "<p>add new template</p>"
# to = '651019063@qq.com'
# subject = '邮箱验证'
# require 'json'
# # mail@yiliaohj.com
# def send_mail(to, subject)
#   vars = JSON.dump({"sub" => { "%email%" => [to], "%url%" => ['http://www.baidu.com']} })
#   response = RestClient.post 'http://sendcloud.sohu.com/webapi/mail.send_template.json',{
#     api_user: 'yiliaohj_mail',
#     api_key: 'qMgh602Vx1zeL4kf',
#     from: Settings.mail.from,
#     fromname: "搜医搜",
#     to: to,
#     substitution_vars: vars,
#     subject: subject,
#     template_invoke_name: 'email_confirmation',
#     resp_email_id: 'true'
#   }
#   debugger
#   puts "zzzzzzz"
#   puts response
#   puts response.code
# end

# send_mail(to, subject)


# frontend_users_confirmation
# "<p>你好 %email%!</p><p>欢迎注册医一得</p><a href='%url%'>点击验证您的邮件</a>"

# https://sendcloud.sohu.com/apiv2/template/add?apiUser=yiliaohj_mail&apiKey=qMgh602Vx1zeL4kf&invokeName=email_confirmation&name=%E9%82%AE%E7%AE%B1%E9%AA%8C%E8%AF%81&subject=%E9%82%AE%E7%AE%B1%E9%AA%8C%E8%AF%81&html=%3Cp%3E%E4%BD%A0%E5%A5%BD%20%25email%25!%3C%2Fp%3E%3Cp%3E%E6%AC%A2%E8%BF%8E%E6%B3%A8%E5%86%8C%E5%8C%BB%E4%B8%80%E5%BE%97%3C%2Fp%3E%3Ca%20href%3D'%25url%25'%3E%E7%82%B9%E5%87%BB%E9%AA%8C%E8%AF%81%E6%82%A8%E7%9A%84%E9%82%AE%E4%BB%B6%3C%2Fa%3E&templateType=1



#!/usr/bin/env ruby
# http://sendcloud.sohu.com/webapi/template.get.json?api_user=yiliaohj_mail&api_key=qMgh602Vx1zeL4kf
require 'rubygems'
require 'rest_client'
require 'json'

# {
# invoke_name: "testtemplate2",
# name: "test2",
# html: "<p>add %url% new template</p>",
# subject: "test_subject",
# email_type: 1,
# is_verify: 1,
# gmt_created: "2016-03-24 12:06:35",
# gmt_modified: "2016-03-24 12:08:33"
# },

def send_mail
  vars = JSON.dump({"to" => ['651019063@qq.com'], "sub" => { "%url%" => ["http://7xi9bi"]} })
  response = RestClient.post "http://sendcloud.sohu.com/webapi/mail.send_template.json",
  :api_user => "yiliaohj_mail", # 使用api_user和api_key进行验证
  :api_key => "qMgh602Vx1zeL4kf",
  :from => "mail@yiliaohj.com", # 发信人，用正确邮件地址替代
  :fromname => "搜医搜",
  :substitution_vars => vars,
  :template_invoke_name => 'test_template_active',
  :subject => "邮箱验证",
  :resp_email_id => 'true'

  return response
end

response = send_mail
puts response.code
puts response.to_str

# x_smtpapi = {
#     to: ["651019063@qq.com"],
#     sub: {
#         "%email%": ['651019063@qq.com']
#     }
# }
# vars = JSON.dump({"to" => ['651019063.com'], "sub" => { "%email%" => ['651019063.com']} })
# vars = JSON.dump({"to" => ['651019063.com'], "sub" => { "%email%" => ['651019063.com'], "%url%" => ['http://www.baidu.com']} })


# require 'rubygems'
# require 'rest_client'
# require 'json'


# def send_mail
#         vars = JSON.dump({"to" => ['to1@domain.com'], "sub" => { "%code%" => ['123456']} })
#         response = RestClient.post "http://sendcloud.sohu.com/webapi/mail.send_template.json",
#         :api_user => "...", # 使用api_user和api_key进行验证
#         :api_key => "...",
#         :from => "sendcloud@sendcloud.org", # 发信人，用正确邮件地址替代
#         :fromname => "SendCloud",
#         :substitution_vars => vars,
#         :template_invoke_name => 'sendcloud_template',
#         :subject => "SendCloud ruby webapi template example",
#         :resp_email_id => 'true'

# return response
# end

# response = send_mail
# puts response.code
# puts response.to_str