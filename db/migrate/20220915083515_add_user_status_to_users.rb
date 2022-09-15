class AddUserStatusToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_status, :boolean, default: false
  end
end
