Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "users#index"

  # When someone visits this URL, "users#show" will invoke the show action in the UsersController

  get "/users", to: 'users#index', as: 'users'

  get "/users/:user_id", to: 'users#show', as: 'user'

  # "as: 'user_posts'" is giving a name to this route. This name, user_posts, becomes a method that you can use in your Rails views or controllers to generate the URL associated with this route.
  # you can use user_posts_path to generate the URL for the route "/users/:user_id/posts"
  
  get "users/:user_id/posts", to:'posts#index', as: 'user_posts'

  get "users/:user_id/posts/:id", to: 'posts#show', as: 'user_post'

  get "/users/:user_id/posts/:post_id/comments", to: 'comments#new', as: 'user_post_comments'
end
