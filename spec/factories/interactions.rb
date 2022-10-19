# frozen_string_literal: true

FactoryBot.define do
  factory :interaction do
    interaction_type { 'fault' }
    description { Faker::Lorem.sentence }
    time { 1 }
    minutes { 1 }
  end
end
