class AddTypeToInteraction < ActiveRecord::Migration[7.0]
  def change
    add_column :interactions, :type, :string
    add_index :interactions, %i[id type]
  end
end
