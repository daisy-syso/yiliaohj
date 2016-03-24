require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  # for static html
  %w{register_with_email finish_user_info_for_phone_register finish_user_info_for_email_register set_password_for_email_register find_password_by_phone find_password_by_email sent_successful hospital_list}.each do |page|
    get "static_pages/#{page}"
  end

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # constraints subdomain: /^(test(.*))$/i do
    namespace :frontend, path: '/' do
      devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations' }

      root 'main#index'
      post 'upload_position',  to: 'main#upload_position'
      namespace :users do
        resources :sms, only: [:create]
        resources :confirmations do
          member do
            get 'reset_email_password'
          end
        end
        resources :registrations do
          collection do
            get 'email_new'
            get 'telephone_new'
            get 'check_register_telephone'
            get 'check_register_email'
            post 'email'
            get 'sent_successful'
            post 'telephone'
          end
        end
        resources :me
        resources :passwords do
          collection do
            get 'telephone_new'
            post 'telephone'

            get 'email_new'
            post 'email'

            get 'email_edit'
          end
        end
        resources :sessions
      end

      resources :hospitals
      resources :maternals
      resources :medicals
      resources :nursing_rooms
    end
  # end

  # constraints subdomain: /^(admin(.*))$/i do
  #   devise_for :admins
  #   mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  #   # namespace :admin, path: '/admin' do
  #   #   resources :banners
  #   #   resources :hot_actions
  #   #   resources :editors_session do
  #   #     collection do
  #   #       get 'login'
  #   #       get 'logout'
  #   #     end
  #   #   end
  #   #   resources :banners
  #   # end
  # end
end

