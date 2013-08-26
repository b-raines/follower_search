class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.string :user_id
      t.string :fid
      t.string :name

      t.timestamps
    end
  end
end
