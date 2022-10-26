class AddReferencesTeamToMatches < ActiveRecord::Migration[7.0]
  def change
    add_reference :matches, :team_away, index: true
    add_reference :matches, :team_home, index: true
    add_index :matches, %i[stage_id team_away_id team_home_id], unique: true
    # add_index :teams, :name, unique: true
  end
end
