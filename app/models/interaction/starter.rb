# frozen_string_literal: true

class Interaction::Starter < Interaction
  def update_match
    match.start!
  end
end
