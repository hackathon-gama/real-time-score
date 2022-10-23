class CreateInteractions < ActiveRecord::Migration[7.0]
  def change
    create_table :interactions do |t|
      t.string :interaction_type, default: 'start_game'
      t.string :description
      t.integer :time
      t.integer :minutes
      t.references :match, foreign_key: true

      t.timestamps
    end
  end
end
