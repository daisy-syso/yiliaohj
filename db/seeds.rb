# editor = Editor.find_or_initialize_by(username: 'admin')
# editor.password = 'Daisy1234'
# editor.save

# a = Admin.new
# a.email = '651019063@qq.com'
# a.password = 'password'
# a.save

Symptom.each_with_index do |value,index|
  value.display_index = index
  value.save
end
