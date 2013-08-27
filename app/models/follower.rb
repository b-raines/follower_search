class Follower < ActiveRecord::Base

  belongs_to :user
  has_many :tweets
  validates :fid, uniqueness: true

end
