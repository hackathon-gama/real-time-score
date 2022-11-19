# frozen_string_literal: true

module UseCases
  class FileMatchCreator < Base
    PERMITED_ATTRIBUTES =
      %w[away_goals home_goals match_date team_away team_home stage].freeze

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

      return if Match.find_by(create_match_relationships(match_attributes))

      Match.create!(match_attributes.merge(create_match_relationships(match_attributes)))
    end

    def create_match_relationships(attributes)
      stage = Stage.find_or_create_by!(name: attributes['stage'])
      team_home = Team.find_or_create_by!(name: attributes['team_home'])
      team_away = Team.find_or_create_by!(name: attributes['team_away'])

      { 'team_home' => team_home, 'team_away' => team_away, 'stage' => stage }
    end
  end
end
