Rails.application.routes.draw do
  root "users#index"
  # Sessions routes
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
 
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
  # Resources for users, tasks, pastas, and listas
  resource :session, only: [:new, :create, :destroy]
  resources :passwords, param: :token
  resources :users
  resources :tasks, only: [:update]
  resources :pastas
  resources :listas
end
