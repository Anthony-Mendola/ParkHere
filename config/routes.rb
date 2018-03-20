Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: "users/omniauth_callbacks" }
root 'listings#index'
end
