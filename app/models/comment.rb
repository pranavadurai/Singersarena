class Comment < ApplicationRecord
  belongs_to :song
  
  default_scope { order(:created_at => :desc)}
end
