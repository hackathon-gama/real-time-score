class CreateStages < ActiveRecord::Migration[7.0]
  def change
    create_table :stages do |t|
      t.string :name, default: 'groups'

      t.timestamps
    end
  end
end
