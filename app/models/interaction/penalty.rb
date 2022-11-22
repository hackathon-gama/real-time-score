# frozen_string_literal: true

class Interaction::Penalty < Interaction
  def update_match
    match.touch
  end
end
