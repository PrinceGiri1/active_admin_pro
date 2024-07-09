class Ability
  include CanCan::Ability
  include ActiveAdminRole::CanCan::Ability

  def initialize(user)
    if user.present?
      if user.admin?
        can :manage, :all
      elsif user.sub_admin?
        can :cretae,ActiveAdmin
        can :manage, Post
        can :manage, Comment
      elsif user.manager?
        can :create, Post
        can :create, Comment
        can :read, Post
      else
        can :read, Post
        can :read, Comment
      end
      can :read, ActiveAdmin::Page, name: "Dashboard"
    end
  end
end
