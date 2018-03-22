Rails.application.routes.draw do
  devise_for :users 

root 'listings#index'

  resources :listings

end
