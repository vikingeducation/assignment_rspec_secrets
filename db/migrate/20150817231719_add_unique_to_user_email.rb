class AddUniqueToUserEmail < ActiveRecord::Migration
  def change
  	remove_column :users, :email
  	add_column :users, :email, :string, :unique => true
  end
end
