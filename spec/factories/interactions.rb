FactoryBot.define do
  factory :interaction do
    interaction_type { "fault" }
    description { "MyString" }
    time { 1 }
    minutes { 1 }
  end
end
