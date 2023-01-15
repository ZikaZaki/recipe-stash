class RecipeFoodController < ApplicationController
  before_action :set_recipe_food, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show public_recipes]

  # GET /recipe_food or /recipe_food.json
  def index
    @recipe_foods = RecipeFood.all
    @recipe_food = RecipeFood.new
  end

  def new
    @foods = Food.all.map { |food| [food.name, food.id] }
    @recipe_id = params[:id]
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new
    @recipe_food.quantity = ingredient_params[:qty]
    @recipe_food.food = Food.find(ingredient_params[:food])
    @recipe_food.recipe = Recipe.find(params[:id])
    if @recipe_food.save
      redirect_to recipe_details_path(id: @recipe_food.recipe.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def ingredient_params
    params.require(:new_recipe_food).permit(:qty, :food)
  end
end
