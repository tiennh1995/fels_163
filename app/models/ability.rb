class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    alias_action :new, :create, :edit, :update, :destroy, to: :crud
    if user.is_admin?
      can :manage, :all
      cannot :crud, User do |other_user|
        other_user.is_admin?
      end
    else
      can :read, :all
      can [:create, :update], Lesson, user_id: user.id
      cannot :read, Log
    end
  end
end
