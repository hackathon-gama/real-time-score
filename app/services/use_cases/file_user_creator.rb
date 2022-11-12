# frozen_string_literal: true

module UseCases
  class FileUserCreator < Base
    attr_reader :file_extractor, :permited_attributes

    def initialize(file_extractor, permited_attributes:)
      @file_extractor = file_extractor
      @permited_attributes = permited_attributes
    end

    def call
      import_users_attributes do |user_attributes|
        create_user(user_attributes)
      end
    end

    private

    def import_users_attributes(&block)
      @file_extractor.execute(&block)
    end

    def create_user(user_attributes)
      user_attributes = user_attributes.select do |attribute|
        attribute.to_s.in?(permited_attributes)
      end

      User.create!(user_attributes)
    end
  end
end
