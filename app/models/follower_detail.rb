class FollowerDetail < ApplicationRecord

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"


  validates :follower_id, presence: true
  validates :followed_id, presence: true

  scope :user_message, ->(user_id) do
    where("follower_id = ? OR followed_id = ?",user_id,user_id)
  end

end
