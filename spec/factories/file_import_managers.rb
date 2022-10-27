# frozen_string_literal: true

FactoryBot.define do
  factory :file_import_manager do
    status { 'pending' }
    retries { 0 }
  end
end
