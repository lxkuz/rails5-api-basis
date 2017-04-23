require 'rails_helper'

RSpec.describe Report, type: :model do
  context 'admin ability allow' do
    let(:admin_ability) { Ability.new admin }
    let(:admin) { FactoryGirl.create :user, :admin }

    it 'to manage users' do
      expect(admin_ability.can?(:manage, User)).to eq(true)
    end

    it 'to manage tickets' do
      expect(admin_ability.can?(:manage, Ticket)).to eq(true)
    end

    it 'to manage reports' do
      expect(admin_ability.can?(:manage, Report)).to eq(true)
    end

    it 'to manage ticket kinds' do
      expect(admin_ability.can?(:manage, TicketKind)).to eq(true)
    end
  end

  context 'agent ability allow' do
    let(:agent_ability) { Ability.new agent }
    let(:agent) { FactoryGirl.create :user, :agent }
    let(:ticket) { FactoryGirl.create :ticket }

    it 'to read users' do
      expect(agent_ability.can?(:read, User)).to eq(true)
    end

    it 'NOT to create users' do
      expect(agent_ability.can?(:create, User)).to eq(false)
    end

    it 'to update tickets' do
      expect(agent_ability.can?(:update, ticket)).to eq(true)
    end

    it 'NOT to destroy tickets' do
      expect(agent_ability.can?(:destroy, ticket)).to eq(false)
    end

    it 'to read tickets' do
      expect(agent_ability.can?(:read, Ticket)).to eq(true)
    end

    it 'to create report' do
      expect(agent_ability.can?(:create, Report)).to eq(true)
    end

    it 'NOT to destroy reports' do
      expect(agent_ability.can?(:destroy, Report)).to eq(false)
    end

    it 'to read reports' do
      expect(agent_ability.can?(:read, Report)).to eq(true)
    end

    it 'to read ticket kinds' do
      expect(agent_ability.can?(:read, TicketKind)).to eq(true)
    end
  end
  context 'customer ability allow' do
    let(:customer_ability) { Ability.new customer }

    let(:customer) { FactoryGirl.create :user, :customer }
    let(:admin) { FactoryGirl.create :user, :customer }

    let(:ticket) { FactoryGirl.build :ticket, customer: customer }

    it 'to create own tickets' do
      expect(customer_ability.can?(:create, ticket)).to eq(true)
    end

    it 'to read own tickets' do
      expect(customer_ability.can?(:read, ticket)).to eq(true)
    end

    it 'to read own user' do
      expect(customer_ability.can?(:read, customer)).to eq(true)
    end

    it 'to read ticket kinds' do
      expect(customer_ability.can?(:read, TicketKind)).to eq(true)
    end

    it 'NOT to create ticket kinds' do
      expect(customer_ability.can?(:create, TicketKind)).to eq(false)
    end

    it 'NOT to destroy ticket kinds' do
      expect(customer_ability.can?(:destroy, TicketKind)).to eq(false)
    end

    it 'NOT to destroy tickets' do
      expect(customer_ability.can?(:destroy, ticket)).to eq(false)
    end

    it 'NOT to create users' do
      expect(customer_ability.can?(:create, User)).to eq(false)
    end
  end
end
