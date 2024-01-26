Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#index"

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts do
          collection do
            get 'all'
          end
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
  

  # IMP : if we write resource we only get one route but if we write resources we get seven routes ,  you can check that using "rails routes "

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy], controller: 'comments'
      resources :likes, only: [:create, :destroy], controller: 'likes'
    end
  end
end
