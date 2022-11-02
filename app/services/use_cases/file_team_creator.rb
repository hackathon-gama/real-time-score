# frozen_string_literal: true

module UseCases
  class FileTeamCreator < Base
    attr_reader :file_extractor, :permited_attributes

    def initialize(file_extractor, permited_attributes:)
      @file_extractor = file_extractor
      @permited_attributes = permited_attributes
    end

    def call
      import_teams_attributes do |team_attributes|
        create_team(team_attributes)
      end
    end

    private

    def import_teams_attributes(&block)
      @file_extractor.execute(&block)
    end

    def create_team(team_attributes)
      team_attributes = team_attributes.select do |attribute|
        attribute.to_s.in?(permited_attributes)
      end

      Team.create!(team_attributes)
    end
  end
end
