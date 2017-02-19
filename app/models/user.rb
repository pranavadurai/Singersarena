class User < ApplicationRecord
  has_one :authentication, dependent: :destroy
  has_many :songs,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :follower_details, foreign_key: "follower_id",dependent: :destroy
  has_many :followeds, through: :follower_details, source: :followed
  has_many :reverse_follower_details, foreign_key: "followed_id",class_name: "FollowerDetail",dependent: :destroy
  has_many :followers, through: :reverse_follower_details, source: :follower
  

  validates :name,presence: true
  validates :email,presence: true

  before_save :change_number_format

  def following?(other_user)
    follower_details.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    follower_details.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    follower_details.find_by_followed_id(other_user.id).destroy
  end

  private
  def change_number_format
    phone = phone.to_i
  end

end
