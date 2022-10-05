FactoryBot.define do
  factory :stage do
    name { Faker::Name.name_with_middle }
  end
end
