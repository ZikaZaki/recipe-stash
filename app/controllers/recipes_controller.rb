class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[public_recipes]

  # GET /recipes or /recipes.json
  def index
    @recipes = current_user.recipes.order('created_at ASC')
    @recipe = Recipe.new
  end

  def public_recipes
    @public_recipes = Recipe.includes(:user).where(public: true)
  end

  def generate_shopping_list
    @recipe_foods = RecipeFood.includes(:food).select { |item| item.food.user_id == current_user.id }
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  # GET /recipes/new
  def new
    @recipe = current_user.recipes.build
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = current_user.recipes.build(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
