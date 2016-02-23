Rails.application.routes.draw do

  constraints :subdomain => /^(admin(.*))$/i  do
    namespace :admin, path: '/' do

      root 'editors_session#login'

      resources :editors_session do
        collection do
          get 'login'
          get 'logout'
        end
      end

      resources :banners

    end
  end

  constraints :subdomain => /^(test(.*))$/i  do
    namespace :frontend, path: '/' do

      devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords", confirmations: "users/confirmations" }

      root 'main#index'
    end
  end

end
