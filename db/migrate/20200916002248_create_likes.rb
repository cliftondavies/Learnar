class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :progress_update, foreign_key: true
      t.index [:user_id, :progress_update_id], unique: true
      t.timestamps
    end
  end
end
