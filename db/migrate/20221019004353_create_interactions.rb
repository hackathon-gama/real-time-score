class CreateInteractions < ActiveRecord::Migration[7.0]
  def change
    create_table :interactions do |t|
      t.string :interaction_type
      t.string :description
      t.integer :time
      t.integer :minutes
      t.belongs_to :match

      t.timestamps
    end
  end
end
