Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "home#index"
  resources :posts do
    resources :comments, only: [:create]
  end
  resources :subscriptions, only: [:create, :destroy]
  get '/vapid_public_key', to: 'vapids#public_key'
  get 'locations/states', to: 'locations#states'
  get 'locations/cities', to: 'locations#cities'

end
