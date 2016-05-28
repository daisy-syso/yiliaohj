require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  # for static html
  %w(register_with_email finish_user_info_for_phone_register finish_user_info_for_email_register set_password_for_email_register find_password_by_phone find_password_by_email sent_successful hospital_list).each do |page|
    get "static_pages/#{page}"
  end

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  constraints subdomain: /^(test(.*))$/i do
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
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :zhongliu_hospitals do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :haiwai_hospitals do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :doctors do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end

        collection do
          post 'like'
        end
      end

      resources :maternities do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :confinement_centers do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :medicals do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :nursing_rooms do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :symptoms do
        collection do
          get 'get_more'
        end
      end

      resources :searches

      resources :categories

      resources :promotions

      resources :buffets do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :subscriptions

      resources :group_buyings

      resources :information

      resources :import_drugs do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :drugs do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :person_customs do
        collection do
          get 'more_information'
          get 'more_questions'
        end
      end

      resources :questions

      resources :insurances do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :examinations do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :drug_stores do
        resources :comments do
          collection do
            get 'get_more_comments'
          end
        end
      end

      resources :all_categories

      resources :maps

      resources :cities do
        collection do
          get 'cities_search'
          get 'get_counties_by_city_name'
        end
      end

      resources :diseases

      resources :strategy_categories do
        member do
          get 'sub_strategy_categories'
        end
        resources :strategies
      end
    end
  end
end
