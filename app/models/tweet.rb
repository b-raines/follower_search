class Tweet < ActiveRecord::Base

  belongs_to :follower
  validates :tid, uniqueness: true

end
