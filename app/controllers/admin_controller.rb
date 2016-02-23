class AdminController < ApplicationController
  layout 'admin/application'

  def check_auth
    if session[:editor] == nil
      redirect_to '/'
    end
  end
end
