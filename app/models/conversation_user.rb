class ConversationUser < ActiveRecord::Base
  validates :user_id, presence: true
  validates :conversation_id, presence: true
end
