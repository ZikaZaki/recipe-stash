Rails.application.routes.draw do
  resources :recipes
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :foods
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "foods#index"
end
