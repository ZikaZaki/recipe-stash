class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, RecipeFood
    return unless user.present?

    # Food related permissions for user
    can :create, Food # any user can create a food
    can :destroy, Food do |food| # only the user who created the food can destroy it
      food.user_id == user.id
    end

    # Recipe related permissions for user
    can :create, Recipe # any user can create a recipe
    can :manage, Recipe do |recipe| # only the user who created the recipe can read it
      recipe.user_id == user.id
    end

    # RecipeFood related permissions for user
    can :create, RecipeFood # any user can create a recipe_food
    can :manage, RecipeFood do |recipe_food| # only the user who created the recipe_food can read it
      recipe_food.user_id == user.id
    end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
