require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  # for static html
  %w(register_with_email finish_user_info_for_phone_register finish_user_info_for_email_register set_password_for_email_register find_password_by_phone find_password_by_email sent_successful hospital_list).each do |page|
    get "static_pages/#{page}"
  end

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # constraints subdomain: /^(test(.*))$/i do
    namespace :frontend, path: '/' do
      devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations' }

      root 'main#index'
      post 'upload_position', to: 'main#upload_position'
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

      resources :hospitals do
        resources :comments
      end

      resources :doctors do
        resources :comments

        collection do
          post 'like'
        end
      end
      resources :maternities
      resources :confinement_centers
      resources :medicals
      resources :nursing_rooms

      resources :searches

      resources :categories

      resources :subscriptions

      resources :information

      resources :person_customs

      resources :questions

      resources :insurances

      resources :examinations

      resources :drug_stores

      resources :maps
    end
  # end
end
