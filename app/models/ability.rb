class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #

    user ||= User.new # guest user (not logged in)

    alias_action :create, :update, :destroy, :to => :cud
    alias_action :create, :update, :to => :cu

    if user.is? :admin
      can :manage, :all
    elsif user.is? :standard
      can :read, :all
      can [:read, :follow, :unfollow], Company
      cannot :import, Company
      can :imageuploader, User, :user_id => user.id
      can [:up, :down], Pitch do |pitch|
        pitch.user_id != user.id
      end
      can [:up, :down], Blip do |blip|
        blip.user_id != user.id
      end
      can [:up, :down], Competitor do |comp|
        comp.user_id != user.id
      end
      can [:up, :down], Risk do |risk|
        risk.user_id != user.id
      end
      can [:up, :down], Question do |q|
        q.user_id != user.id
      end
      can [:up, :down], Question do |a|
        a.user_id != user.id
      end
      can [:blips, :buypitch, :sellpitch, :question, :answer, :comment], User
      can :read, [Blip, Pitch, Catalyst, Question, Answer, Competitor, Risk, Attachment]
      can :update, [Catalyst, Question, Answer, Competitor, Risk], :user_id => user.id
      can :destroy, [Catalyst, Answer, Competitor, Risk, Blip, Attachment], :user_id => user.id
      can :cu, Blip, :user_id => user.id
      can :create, [Comment, Pitch, Blip, Catalyst, Question, Answer, Competitor, Risk, Attachment]
      can :download, Attachment
      can [:update, :destroy], Comment, :user_id => user.id
      can [:update], Pitch, :user_id => user.id
      can :read, Comment
      can :read, User
      can :cu, User, :user_id => user.id
      can :setting, User, :user_id => user.id
      can :credits, User, :user_id => user.id
      can [:blips, :buypitch, :sellpitch], Company
    else
      can :read, :all
      can [:blips, :buypitch, :sellpitch, :question, :answer, :comment], User
      can [:blips, :buypitch, :sellpitch], Company
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end



