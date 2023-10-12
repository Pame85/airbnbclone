Rails.application.routes.draw do
  devise_for :users
  resources :listings, only: [:index, :new, :create]
  resources :bookings

  get '/bookings', to: 'bookings#index'
  root to: "home#index"
end
