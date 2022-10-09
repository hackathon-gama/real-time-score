class CreateStages < ActiveRecord::Migration[7.0]
  def change
    create_table :stages do |t|
      t.integer :name, default: 0

      t.timestamps
    end
  end
end
