class CreateFileImportManagers < ActiveRecord::Migration[7.0]
  def change
    create_table :file_import_managers do |t|
      t.string :status, default: 'pending', null: false
      t.integer :retries, default: 0, null: false

      t.timestamps
    end
  end
end
