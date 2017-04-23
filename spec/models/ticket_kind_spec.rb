require 'rails_helper'

RSpec.describe TicketKind, type: :model do
  subject { described_class.new }

  it 'is not valid without a name' do
    expect(subject).to_not be_valid
  end

  it 'is valid with a name' do
    subject.name = 'Tests'
    expect(subject).to be_valid
  end
end
