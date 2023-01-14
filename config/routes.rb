Rails.application.routes.draw do
  resources :recipes
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :foods
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root "foods#index"
  root to: "recipes#public_recipes"
  get 'recipe/new_ingredient/:id', to: "recipes#new_ingredient", as: "recipe_new_ingredient"
  post 'recipe/create_ingredient/:id', to: "recipes#create_ingredient", as: "recipe_create_ingredient"
  get 'recipe/public_recipes', to: "recipes#public_recipes", as: "public_recipes"
end
