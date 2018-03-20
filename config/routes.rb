Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: "users/omniauth_callbacks" }
get '/users/home' => 'users#home', as: "user_home"
root 'listings#index'
  resources :listings do
  resources :types
  resources :reviews
end

get 'all', to: 'listings#index', as: 'all_listings'
end
