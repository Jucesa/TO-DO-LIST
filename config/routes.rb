Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  resources :users do
    resources :lists do
      resources :tasks
    end
  end
  resources :tasks do
    member do
      patch :update_list
      
    end
  end
  resources :tasks
  resources :lists
  root "home#index"
  get "home/index"
  get "home/about"
  get "up" => "rails/health#show", as: :rails_health_check
end