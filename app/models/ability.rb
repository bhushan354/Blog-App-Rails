class Ability
  include CanCan::Ability
  # if operator ||=
  def initialize(user)
    user ||= User.new
  end
