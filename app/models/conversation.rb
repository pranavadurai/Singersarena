class Conversation < ApplicationRecord

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, foreign_key: "receiver_id", class_name: "User"
  has_many   :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :receiver_id

  scope :between, -> (sender_id,receiver_id) do
        where("(conversations.sender_id = ? AND conversations.receiver_id =?) OR (conversations.sender_id = ? AND conversations.receiver_id =?)", sender_id,receiver_id, receiver_id, sender_id)
  end

  scope :user_conversation, -> (user_id) do
        where("sender_id = ? OR receiver_id = ?",user_id,user_id)
  end


end
