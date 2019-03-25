class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 

    if user.role? :commish
        #admins can do everything
        can :manage, :all

    elsif user.role? :chief
        can :read, :all
        can :manage, Investigation
        can :manage, InvestigationNote
        can :manage, CrimeInvestigation
        can :manage, Criminal
        can :manage, Suspect
        can :manage, Assignment
        can :update, User

        can :update, Unit do |u|
            u.id == user.officer.unit_id
        end

        can :manage, Officer do |o|  
          o.unit_id == user.officer.unit_id
        end

    elsif user.role? :officer

        can :read, Investigation
        can :read, Assignment
        can :read, Crime
        can :new,  Investigation
        can :create, Investigation
        can :manage, InvestigationNote
        can :manage, CrimeInvestigation
        can :manage, Criminal
        can :manage, Suspect
        can :index, Unit

        can :update, Investigation do |i|
            my_assignments = i.assignments.current.map(&:officer_id)
            my_assignments.include? user.officer.id
        end


        can :read, Officer do |i|
            i.id == user.officer.id
        end

        can :update, Officer do |i|
            i.id == user.officer.id
        end

        can :read, User do |i|
            i.id == user.id
        end

        can :update, User do |i|
            i.id == user.id
        end

        can :show, Unit do |i|
            i.id == user.officer.unit_id
        end


    else
        can :read, [Crime]
    end
  end
end
