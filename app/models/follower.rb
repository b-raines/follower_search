class Follower < ActiveRecord::Base

  belongs_to :user, foreign_key: "post_id"

  def names
    Follower.all.each do |follower|
      follower.name
    end
  end

end
