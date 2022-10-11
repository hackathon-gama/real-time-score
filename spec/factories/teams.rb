# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Name.name_with_middle }
    description { Faker::Lorem.sentence }

    photo do
      Rack::Test::UploadedFile.new('spec/fixtures/files/photo.png', 'image/png')
    end
  end
end
