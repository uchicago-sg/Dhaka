class Ability
  include CanCan::Ability

  # Should really change this later...
  # Set up a meaningful roles system first, though
  def initialize(user)
    user ||= Profile.new
    can :manage, :all
  end
end