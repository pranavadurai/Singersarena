class Comment < ApplicationRecord
  belongs_to :song
  belongs_to :user
  
  default_scope { order(:created_at => :desc)}
end
