class Conversation < ActiveRecord::Base
  belongs_to :user
  has_many :conversation_users
  validates :user_id, presence: true
end
