FactoryBot.define do
  factory :team do
    name { Faker::Name.name_with_middle  }
    description { Faker::Lorem.sentence }
    photo { Faker::Avatar.image }
  end
end
