# frozen_string_literal: true
require 'spec_helper'

describe Action do
  context 'create/destroy' do
    before do
      @user_act = UserAct.create(:user)
      # @discover_item_ids = DiscoverItem.where(target_type: 'Action',target_id: @action.id).map &:id
    end

    it 'should create action' do
      expect(Action.count).to eq(1)
    end
  end
end
