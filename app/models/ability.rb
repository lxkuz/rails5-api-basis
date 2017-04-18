# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    if user.admin?
      can :manage, :all
    elsif user.agent?
      can [:update, :read], Ticket
      can [:create, :read], Report
      can :read, User
      can :read, TicketKind
    elsif user.customer?
      can :create, Ticket do |ticket|
        ticket.customer_id == user.id
      end
      can :read, Ticket, customer_id: user.id
      can :read, User, id: user.id
      can :read, TicketKind
    end
  end
end
