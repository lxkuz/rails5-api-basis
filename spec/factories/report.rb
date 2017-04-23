# frozen_string_literal: true
FactoryGirl.define do
  factory :report do
    title { Faker::Company.name }
    data do
      { count: rand(100) }
    end
    report_from { Time.now - 1.month }
    report_to { Time.now }
  end
end
