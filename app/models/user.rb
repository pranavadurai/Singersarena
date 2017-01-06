class User < ApplicationRecord
  has_one :authentication, dependent: :destroy



  validates :name,presence: true
  validates :email,presence: true

end
