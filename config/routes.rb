Rails.application.routes.draw do

  constraints :subdomain => /^(admin(.*))$/i  do

    devise_for :admins#, controllers: { sessions: "users/sessions" }
    mount RailsAdmin::Engine => '/', as: 'rails_admin'

    namespace :admin, path: '/' do

    #   root 'editors_session#login'
      resources :banners
      resources :hot_actions

    #   resources :editors_session do
    #     collection do
    #       get 'login'
    #       get 'logout'
    #     end
    #   end

    #   resources :banners

    end
  end

  constraints :subdomain => /^(test(.*))$/i  do
    namespace :frontend, path: '/' do

      devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords", confirmations: "users/confirmations" }

      root 'main#index'
    end
  end

end
