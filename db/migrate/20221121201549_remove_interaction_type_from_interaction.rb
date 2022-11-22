class RemoveInteractionTypeFromInteraction < ActiveRecord::Migration[7.0]
  def change
    remove_column :interactions, :interaction_type, :string
  end
end
