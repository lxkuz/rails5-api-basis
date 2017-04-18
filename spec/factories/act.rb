# frozen_string_literal: true
FactoryGirl.define do
  factory :act do
    association :user, strategy: :build
    title { Faker::Name.name }
  end
end
