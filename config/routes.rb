require 'sidekiq/web'
Rails.application.routes.draw do
  # for static html
  %w{register_with_email finish_user_info_for_phone_register finish_user_info_for_email_register set_password_for_email_register }.each do |page|
    get "static_pages/#{page}"
  end

  mount Sidekiq::Web, at: '/sidekiq'
  constraints subdomain: /^(test(.*))$/i do
    namespace :frontend, path: '/' do
      devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations' }

      root 'main#index'
      post 'upload_position',  to: 'main#upload_position'
      namespace :users do
        resources :sms, only: [:create]
        resources :registrations, only: [] do
          collection do
            get 'email_new'
            get 'telephone_new'
            get 'check_register_telephone'
            get 'check_register_email'
            post 'email'
            post 'telephone'
          end
        end
        resources :sessions, only: [:new, :create, :put]
      end

      resources :hospitals
      resources :maternals
      resources :medicals
      resources :nursing_rooms
    end
  end

  constraints subdomain: /^(admin(.*))$/i do
    devise_for :admins # , controllers: { sessions: "users/sessions" }
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

    namespace :admin, path: '/admin' do
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
end

