Rails.application.routes.draw do

  constraints :subdomain => /^(admin(.*))$/i  do
    namespace :admin, path: '/' do

      root 'users#login'
    end
  end

  namespace :frontend, path: '/' do
    root 'main#index'
  end

end
