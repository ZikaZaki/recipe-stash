class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_index :users, :username, unique: true
  end
end
