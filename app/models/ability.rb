class Ability
  include CanCan::Ability

  def initialize(user)
		user ||= User.new
		if user.role == 'admin' # admin
			can :manage, :all
		elsif user.role == 'coordinator' # coordinator
			can :manage, :all
			cannot :manage, User
		elsif user.role == 'staff' # staff
			can :manage, :all
			cannot :manage, User
			cannot :approve, :all
			cannot :destroy, :all
		elsif user.role == 'guest' # guest
			can :create, Eventlog
		else
			cannot :manage, :all
		end
	end
end
