# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :admin do
      role 'admin'
    end

    trait :customer do
      role 'customer'
    end

    trait :agent do
      role 'agent'
    end
  end
end
