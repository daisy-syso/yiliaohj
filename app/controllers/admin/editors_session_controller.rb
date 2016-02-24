# class Admin::EditorsSessionController < AdminController

#   def create
#     username = params[:editor][:username]
#     password = params[:editor][:password]
#     editor = Editor.where(username: username).first
#     if editor && editor.password == password
#       session[:editor] = editor.username
#       redirect_to admin_banners_path
#     else
#       redirect_to login_admin_editors_session_index_path
#     end
#   end

#   def login
#     if session[:editor].present?
#       redirect_to admin_banners_path
#     else
#       @editor = Editor.new
#     end
#   end

#   def logout
#     session[:editor] = nil

#     redirect_to login_admin_editors_session_index_path
#   end

#   private
#   def editor_params
#     params.require(:editor).permit(:username, :password)
#   end
# end
