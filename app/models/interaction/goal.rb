# frozen_string_literal: true

class Interaction::Goal < Interaction
  def update_match
    match.increment_goals!(team_id:)
  end
end
