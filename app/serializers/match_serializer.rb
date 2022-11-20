# frozen_string_literal: true

class MatchSerializer
  attr_reader :match

  def initialize(match)
    @match = match
  end

  def as_json
    {
      team_home: team_home.name,
      team_away: team_away.name,
      stage: stage.name,
      home_goals: match.home_goals,
      away_goals: match.away_goals,
      status: match.status,
      match_date: match.match_date
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
