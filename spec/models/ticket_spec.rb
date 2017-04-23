require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it 'is not valid without a name'
  it 'is not valid without a description'
  it 'is not valid without a ticket_kind'
end
