class RemoveFollowerIdFromTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :follower_id

    add_column :tweets, :follower_id, :integer
  end
end
