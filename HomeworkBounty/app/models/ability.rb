class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities

    # Access levels
    # Guest: Read everything
    # User: Read everything, create questions, edit own questions
    # Moderator: Read everything, create questions, edit all questions
    # Admin: Read, create, edit, destroy everything
		user ||= User.new # Guest user
		if user.role?(:admin)
			can :manage, :all
		elsif user.role?(:user) or user.role?(:moderator)
			can :read, :all
			can :create, Question
			can :create, Answer
			can :update, User do |u|
				u == user
			end
			if user.role?(:moderator)
				can :manage, Question
				can :manage, Answer
			else
				can :update, Question do |question|
					question.try(:author_to_question) == user
				end

				can :update, Answer do |answer|
					answer.try(:author_to_answer) == user
				end
			end
		else
			can :read, :all
		end
  end
end
