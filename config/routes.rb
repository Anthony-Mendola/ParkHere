Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: "users/omniauth_callbacks" }

root 'listings#index'
get 'all', to: 'listings#index', as: 'all_listings'
end
