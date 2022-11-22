Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Dashboard
  get "profile", to: "dashboards#profile"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :flights do
    resources :bookings, only: %I[index show new create]
  end
  resources :bookings, only: %I[destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
