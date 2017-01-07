class Song < ApplicationRecord
  belongs_to :user
  has_many :comments,dependent: :destroy

  default_scope  { order(:created_at => :desc) }
end
