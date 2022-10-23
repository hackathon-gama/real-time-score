class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.integer :home_goals, index: { unique: true }
      t.integer :away_goals, index: { unique: true }
      t.string :status, default: 'pending'
      t.datetime :match_date
      t.references :stage, null: false, foreign_key: true, index: { unique: true }
      t.references :team, foreign_key: true
      t.timestamps
    end
  end
end
