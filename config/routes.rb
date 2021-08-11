Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecasts#show'

      get '/breweries', to: 'breweries#index'

      resources :users, only: :create
    end
  end
end
