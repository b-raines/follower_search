class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :follower_id
      t.string :tid
      t.string :content

      t.timestamps
    end
  end
end
