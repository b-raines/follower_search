class RemoveUserIdFromFollowers < ActiveRecord::Migration
  def change
    remove_column :followers, :user_id

    add_column :followers, :user_id, :integer
  end
end
