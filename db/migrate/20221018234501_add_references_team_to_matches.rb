class AddReferencesTeamToMatches < ActiveRecord::Migration[7.0]
  def change
    add_reference :matches, :team_away, index: true
    add_reference :matches, :team_home, index: true
  end
end
