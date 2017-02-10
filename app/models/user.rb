class User < ApplicationRecord
  has_one :authentication, dependent: :destroy
  has_many :songs,dependent: :destroy
  has_many :comments


  validates :name,presence: true
  validates :email,presence: true

  before_save :change_number_format

  private
  def change_number_format
    phone = phone.to_i
  end

end
