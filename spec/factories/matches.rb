# frozen_string_literal: true

FactoryBot.define do
  factory :match do
    home_goals { 1 }
    away_goals { 1 }
    status { 'running' }
    match_date { '2022-10-11 23:22:10' }
    stage
    association :team_away, factory: :team
    association :team_home, factory: :team
  end
end
