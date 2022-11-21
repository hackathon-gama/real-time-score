# frozen_string_literal: true

FactoryBot.define do
  factory :interaction do
    description { Faker::Lorem.sentence }
    time { 1 }
    minutes { 1 }
    match

    factory :interaction_starter, class: 'Interaction::Starter'
    factory :interaction_finisher, class: 'Interaction::Finisher'
    factory :interaction_goal, class: 'Interaction::Goal'
    factory :interaction_penalty, class: 'Interaction::Penalty'
    factory :interaction_fault, class: 'Interaction::Fault'
    factory :interaction_corner_kick, class: 'Interaction::CornerKick'
  end
end
