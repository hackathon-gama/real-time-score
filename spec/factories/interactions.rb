# frozen_string_literal: true

FactoryBot.define do
  factory :interaction do
    description { Faker::Lorem.sentence }
    time { 1 }
    minutes { 1 }
    match

    factory :interaction_starter, class: Interaction::Starter
    factory :interaction_finisher, class: Interaction::Finisher
  end
end
