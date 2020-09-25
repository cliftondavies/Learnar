class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string, limit: 15, null: false
    add_column :users, :full_name, :string, null: false
    add_column :users, :photo, :string
    add_column :users, :cover_image, :string
    add_index :users, :username, unique: true
  end
end
