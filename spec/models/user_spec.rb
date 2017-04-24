require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is not valid without a email' do
    user = FactoryGirl.build :user, :customer
    user.email = nil
    expect(user).not_to be_valid
  end
end
