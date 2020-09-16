class CreateProgressUpdates < ActiveRecord::Migration[5.2]
  def change
    create_table :progress_updates do |t|
      t.references :author, index: :false, foreign_key: { to_table: :users }
      t.string :text, limit: 255, null: false
      t.timestamps
    end
  end
end
