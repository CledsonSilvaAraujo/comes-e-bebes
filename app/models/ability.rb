# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    # byebug
      user ||= User.new # guest user (not logged in)
      #can :manage, :all
      
      case user.role
        when "admin"
          
          can [:manage], User
          # can [:]
          #do something
          
        when "owner"
          
          can [:create, :read, :update, :delete, :results], Restaurant, owner_id: user.id
          can [:manage, :create], Dish, restaurant_id: Restaurant.where(owner_id: user.id).first.id
          can [:read, :update, :destroy, :conclude_order], Order, restaurant_id: Restaurant.where(owner_id: user.id).first.id
          can [:read], OrderDish, order_id: Order.where(restaurant_id: Restaurant.where(owner_id: user.id).first.id)
          
          #do something
          
        when "client"
          can [:read], Restaurant
          can [:create_cart, :read], Order
          can [:index, :add_item,:show], OrderDish
          
        when "deliveryman"
          if user.is_valid?
            can [:read, :is_done], Order 
          else #user.is_valid == true
            can [:read], Order
          end
        else #default
          
          #do something else
        end
     
      # elsif user.owner?
      #   # cannot :manage, User
      #   can [:read, :update, :destroy], User, id: user.id
      #   # can :read, :all
      # end
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
