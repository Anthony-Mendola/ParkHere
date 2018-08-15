Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

root 'listings#index'

  resources :listings do
    resources :reviews #Nested Resource
  end

  resources :categories do
    resources :listings
  end

  get '/listings/:id/next', to: 'listings#next_listing'

  get '/listings/:id/previous', to: 'listings#previous_listing'
end


#resources method - RESTful defaults
