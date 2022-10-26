# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name_with_middle }
    email { Faker::Internet.email }
    password_digest { Faker::Internet.password }
  end
end
