class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.foreign_key :users
      t.foreign_key :progress_updates
      t.index [:user_id, :progress_update_id], unique: true
      t.timestamps
    end
  end
end
