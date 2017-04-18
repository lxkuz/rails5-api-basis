
# frozen_string_literal: true
FactoryGirl.define do
  factory :organization do
    association :user, strategy: :build
    name { Faker::Company.name }
    byline { Faker::Company.catch_phrase }
    description { Faker::Lorem.paragraph }

    trait :with_tags do
      tags do
        [
          build(:tag, title: 'tag1'),
          build(:tag, title: 'tag2')
        ]
      end
    end
  end
end
