# frozen_string_literal: true

class Interaction::CornerKick < Interaction
  def update_match
    match.touch
  end
end
