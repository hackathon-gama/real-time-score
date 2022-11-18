class RemoveStageIdIndexFromMatches < ActiveRecord::Migration[7.0]
  def change
    remove_index :completions, name: 'index_matches_on_stage_id'
  end
end
