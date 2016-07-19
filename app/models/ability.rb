class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    user ||= User.new
    alias_action :new, :create, :edit, :update, :destroy, to: :crud
    case controller_namespace
    when "Admin"
      if user.is_admin?
        can :manage, :all
        cannot :crud, User do |other_user|
          other_user.is_admin?
        end
      end
    else
      unless user.is_admin?
        can :read, :all
        can :manage, Lesson, user_id: user.id
        cannot :read, Log
      end
    end
  end
end
