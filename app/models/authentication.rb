class Authentication < ApplicationRecord
  has_secure_password
  belongs_to :user

  validates :email,presence: true
  validates :password_digest,presence: true

  before_save :create_remember_token

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
