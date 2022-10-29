# frozen_string_literal: true

module UseCases
  class FileStageCreator < Base
    attr_reader :file_extractor, :permited_attributes

    def initialize(file_extractor, permited_attributes:)
      @file_extractor = file_extractor
      @permited_attributes = permited_attributes
    end

    def call
      import_stages_attributes do |stage_attributes|
        create_stage(stage_attributes)
      end
    end

    private

    def import_stages_attributes(&block)
      @file_extractor.execute(&block)
    end

    def create_stage(stage_attributes)
      stage_attributes = stage_attributes.select do |attribute|
        attribute.to_s.in?(permited_attributes)
      end

      Stage.create!(stage_attributes)
    end
  end
end
