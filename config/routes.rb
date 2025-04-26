Rails.application.routes.draw do
  # Define your application routes
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post '/login', to: 'auth#login'
  post '/register', to: 'auth#register'

  resources :contacts do
    resources :notes
  end

  # New route for the JWT client page
  get '/jwt-client', to: 'pages#jwt_client', as: 'jwt_client'

  root to: redirect("/jwt-client")
end
