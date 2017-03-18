class User < ApplicationRecord
  has_one :authentication, dependent: :destroy
  has_many :songs,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :followeds, foreign_key: "follower_id",class_name: "FollowerDetail",dependent: :destroy
  has_many :followers, foreign_key: "followed_id",class_name: "FollowerDetail",dependent: :destroy
  has_many :conversations_send, foreign_key: "sender_id",class_name: "Conversation",dependent: :destroy
  has_many :conversations, foreign_key: "receiver_id", dependent: :destroy

  validates :name,presence: true
  validates :email,presence: true

  before_save :change_number_format

  def following?(other_user)
    followeds.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    followeds.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    followeds.find_by_followed_id(other_user.id).destroy
  end

  private
  def change_number_format
    phone = phone.to_i
  end

end
