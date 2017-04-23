# frozen_string_literal: true
FactoryGirl.define do
  factory :ticket_kind do
    name { Faker::Company.name }
  end
end
