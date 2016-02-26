class AdminController < ApplicationController
  layout 'admin/application'

  def check_auth
    redirect_to '/' if session[:editor].nil?
  end
end
