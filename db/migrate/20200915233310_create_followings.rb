class CreateFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :followings do |t|
      t.references :follower, index: :false, foreign_key: { to_table: :users }
      t.references :followed, index: :false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
