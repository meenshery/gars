class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Game

    return unless user.present?

    can :manage, Collection, user_id: user.id

    return unless user.admin?

    can :access, :admin
    can :manage, Post
    can :read, Subscription
  end
end