# frozen_string_literal: true

module UseCases
  class FileMatchCreator < Base
    attr_reader :file_extractor, :permited_attributes

    def initialize(file_extractor, permited_attributes:)
      @file_extractor = file_extractor
      @permited_attributes = permited_attributes
    end

    def call
      import_matches_attributes do |match_attributes|
        create_match(match_attributes)
      end
    end

    private

    def import_matches_attributes(&block)
      @file_extractor.execute(&block)
    end

    def create_match(match_attributes)
      match_attributes = match_attributes.select do |attribute|
        attribute.to_s.in?(permited_attributes)
      end

      Match.create!(match_attributes)
    end
  end
end
