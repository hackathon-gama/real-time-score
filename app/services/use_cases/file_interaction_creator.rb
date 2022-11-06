# frozen_string_literal: true

module UseCases
  class FileInteractionCreator < Base
    attr_reader :file_extractor, :permited_attributes

    def initialize(file_extractor, permited_attributes:)
      @file_extractor = file_extractor
      @permited_attributes = permited_attributes
    end

    def call
      import_interaction_attributes do |interaction_attributes|
        create_interaction(interaction_attributes)
      end
    end

    private

    def import_interaction_attributes(&block)
      @file_extractor.execute(&block)
    end

    def create_interaction(interaction_attributes)
      interaction_attributes = interaction_attributes.select do |attribute|
        attribute.to_s.in?(permited_attributes)
      end

      Interaction.create!(interaction_attributes)
    end
  end
end
