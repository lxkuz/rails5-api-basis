# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    # name  { Faker::Name.name }
    # username {Faker::Internet.user_name }
    password { Faker::Internet.password }

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
