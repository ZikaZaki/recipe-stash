class Ability
  include CanCan::Ability

  def initialize(user)
    # can :read, RecipeFood
    return unless user.present?

    # can :manage, Recipe, user_id: user.id
    can :create, Food
    can :destroy, Food, user_id: user.id
    # can :create, RecipeFood

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
