Rails.application.routes.draw do

  # constraints :subdomain => /^(admin(.*))$/i  do
    # namespace :admin, path: '/' do

    #   root 'editors_session#login'

    #   resources :editors_session do
    #     collection do
    #       get 'login'
    #       get 'logout'
    #     end
    #   end

    # end
  # end

  # constraints :subdomain => /^(test(.*))$/i  do
    namespace :frontend, path: '/' do

      root 'main#index'
    end
  # end

end
