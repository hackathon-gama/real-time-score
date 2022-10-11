class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name, unique: true
      t.string :description

      t.timestamps
    end
  end
end
