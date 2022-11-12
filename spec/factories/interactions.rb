# frozen_string_literal: true

FactoryBot.define do
  factory :interaction do
    interaction_type { 'start_game' }
    description { Faker::Lorem.sentence }
    time { 1 }
    minutes { 1 }
    match
  end
end
