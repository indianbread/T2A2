# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end

    can :read, Product, public: true
    can :read, Category, public: true
    can :read, Brand, public: true
    can :read, Ingredient, public: true


    if user.present?  # additional permissions for logged in users (they can read their own posts)
      can :read, Product
      can :read, Category
      can :read, Brand
      can :read, Ingredient
      can :read, :create, Order, user_id: user.id
      can :crud, Product, user_id: user.id
      can :crud, ProductIngredient
      can :crud, UserInfo, user_id: user.id
      can :crud, Address, user_id: user.id
      if user.admin?
        can :manage, :all 
      end
    end

 
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
