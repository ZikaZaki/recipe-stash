def index
    @recipe_foods = RecipeFood.all
  end

  def new
    @recipe_food = RecipeFood.new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = Food.where(user_id: current_user.id)
  end

  def create
    @recipe_food = RecipeFood.new(params.require(:recipe_food).permit(:qty, :food_id))
    @recipe = Recipe.find(params[:recipe_id])

    @recipe_food.recipe_id = @recipe.id

    if @recipe_food.save
      flash[:success] = 'Food is added successfully'
      redirect_to recipe_path(@recipe)
    else
      flash.now[:error] = 'Food is not added!!!'
      redirect_to new_recipe_recipe_food_path(@recipe)
    end
  end

  def destroy
    RecipeFood.find(params[:id]).destroy
    redirect_to recipe_path(params[:recipe_id])
  end

#   def destroy
#     RecipeFood.find_by(id: params[:id]).destroy
#     redirect_back(fallback_location: root_path)
#   end

def edit_form
  @foods = Food.all.map { |food| [food.name, food.id] }
  @recipe_food = RecipeFood.new
  @recipe_food_id = params[:id]
end

def edit
  recipe_food = RecipeFood.find(params[:id])
  recipe_food.quantity = ingredient_params[:qty]
  recipe_food.food = Food.find(ingredient_params[:food])
  if recipe_food.save
    redirect_to recipe_details_path(id: recipe_food.recipe.id)
  else
    redirect_back(fallback_location: root_path)
  end
end

private

def ingredient_params
  params.require(:new_recipe_food).permit(:qty, :food)
end