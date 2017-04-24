require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:ticket) { FactoryGirl.create :ticket }
  let(:agent) { FactoryGirl.create :user, :agent }
  let(:closed_ticket) { FactoryGirl.create :ticket, :closed }

  # it 'is not valid without a name'
  # it 'is not valid without a description'
  # it 'is not valid without a ticket_kind'

  it 'is not valid without a closing_description on closing' do
    ticket.status = 'closed'
    expect(ticket).not_to be_valid
  end

  it 'is valid with a closing_description and agent on closing' do
    ticket.status = 'closed'
    ticket.closing_description = 'closed by test'
    ticket.agent = agent
    expect(ticket).to be_valid
  end

  it 'should auto-fill closed_at field on closing' do
    expect(closed_ticket.closed_at).not_to be_nil
  end
end
