Rails.application.routes.draw do
  # resources :recipes
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :foods

  root to: "recipes#public_recipes"
  resources :recipes, only: [:index, :show, :new, :create, :destroy, :update] do
    resources :recipe_foods
  end
  get 'recipe/public_recipes', to: "recipes#public_recipes", as: "public_recipes"
  get 'recipe/show/shopping_list/:id', to: "recipes#generate_shopping_list", as: "shopping_list"
end
