class Interaction::Finisher < Interaction
  def update_match
    match.done!
  end
end
