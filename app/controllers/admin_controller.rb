class AdminController < ApplicationController
  layout 'admin/application'

  def check_auth
    if session[:user] == nil
      redirect_to '/'
    end
  end
end
