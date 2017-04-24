require 'rails_helper'

RSpec.describe Report, type: :model do
  context 'after 10 closed tickets' do
    before(:each) do
      10.times do
        FactoryGirl.create :ticket, :closed, agent: agent
      end
    end

    let(:agent) { FactoryGirl.create :user, :agent }
    let(:report) { FactoryGirl.create :report }

    it 'report should have correct closed count' do
      expect(report.data['count']).to eq(10)
    end

    it 'report should have correct closed count' do
      expect(report.data['agents_count']).not_to be_nil
    end

    it 'report should have correct closed count' do
      expect(report.data['agents_count'].keys).to include(agent.id.to_s)
    end
  end
end
