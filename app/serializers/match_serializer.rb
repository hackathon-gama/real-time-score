# frozen_string_literal: true

class MatchSerializer
  attr_reader :match

  def initialize(match)
    @match = match
  end

  def as_json
    {
      id: match.id,
      team_home: team_home.name,
      team_away: team_away.name,
      team_home_id: team_home.id,
      team_away_id: team_away.id,
      stage: stage.name,
      home_goals: match.home_goals,
      away_goals: match.away_goals,
      status: match.status,
      match_date: match.match_date,
      updated_at: match.updated_at
    }.as_json
  end

  private

  def stage
    @stage ||= match.stage
  end

  def team_home
    @team_home ||= match.team_home
  end

  def team_away
    @team_away ||= match.team_away
  end
end
