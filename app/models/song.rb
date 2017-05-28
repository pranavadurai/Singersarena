class Song < ApplicationRecord
  belongs_to :user
  has_many :comments,dependent: :destroy

  before_save :change_case
#default_scope  { order(:created_at => :desc) }

  scope :language_fillter, -> (language) do
    return nil if language.blank?
    where("language = ?",language)
  end

  scope :category_fillter, -> (category) do
    return nil if category.blank?
    where("category = ?",category)
  end

  scope :user_filter, -> (user) do
    return nil if user.blank?
    where("user_id = ?",user)
  end

  private
  def change_case
    self.language.downcase!
    self.category.downcase!
  end
end
