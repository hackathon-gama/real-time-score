# frozen_string_literal: true

class Interaction::Fault < Interaction
  def update_match
    match.touch
  end
end
