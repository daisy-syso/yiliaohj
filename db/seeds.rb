editor = Editor.find_or_initialize_by(username: 'admin')
editor.password = 'Daisy1234'
editor.save
