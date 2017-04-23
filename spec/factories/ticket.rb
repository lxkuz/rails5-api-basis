# frozen_string_literal: true
FactoryGirl.define do
  factory :ticket do
    name { Faker::Company.name }
    description { Faker::Lorem.sentence }
    ticket_kind
    customer { FactoryGirl.create :user, :customer }

    trait :closed do
      status 'closed'
      closing_description { Faker::Lorem.sentence }
      closed_at { Time.now }
    end
  end
end
