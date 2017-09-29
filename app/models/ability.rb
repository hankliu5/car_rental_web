class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    alias_action :create, :read, :update, :destroy, to: :crud

    if user.has_role? :user
      can :read, Car
      can %i[create read], Reservation
      cannot :crud, User
      can :read, User.find(user.id)
    elsif user.has_role? :admin
      can :manage, Car
      can :manage, Reservation
      can :crud, User
      cannot :destroy, User, id: user.id
      cannot :crud, User.with_role(:superadmin)
      cannot :update, User.with_role(:admin)
      cannot [:update, :destroy], User.with_role(:user)
    elsif user.has_role? :superadmin
      can :manage, Car
      can :manage, User
      can :manage, Reservation
      cannot [:edit, :update, :destroy], User.with_any_role(:superadmin)
    else
      can :read, Car
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
