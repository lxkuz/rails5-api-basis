# frozen_string_literal: true
require 'spec_helper'

describe Act do
  before do
    @act = FactoryGirl.create(:act)
  end

  context 'create/destroy' do
    it 'should create act' do
      expect(Act.count).to eq(1)
    end

    it 'should delete act' do
      expect { @act.destroy }.to change { Act.count }.by(-1)
    end
  end

  context 'validation' do
    it 'should valid act' do
      expect(@act).to be_valid
    end
  end
end
