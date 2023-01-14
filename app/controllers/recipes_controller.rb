class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show public_recipes]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all.order('created_at ASC')
    @recipe = Recipe.new
  end

  # GET /recipes/1 or /recipes/1.json
  def show; end

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

  def public_recipes
    @public_recipes = Recipe.where(public: true)
  end

  def new_ingredient
    @foods = Food.all.map { |food| [food.name, food.id] }
    @recipe_id = params[:id]
    @recipe_food = RecipeFood.new
  end

  def create_ingredient
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

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
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

  def ingredient_params
    params.require(:new_recipe_food).permit(:qty, :food)
  end
end
