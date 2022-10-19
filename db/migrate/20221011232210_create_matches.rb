class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.integer :home_goals
      t.integer :away_goals
      t.string :status, default: 'pending'
      t.datetime :match_date
      t.references :stage, null: false, foreign_key: true
      t.belongs_to :team

      t.timestamps
    end
  end
end
