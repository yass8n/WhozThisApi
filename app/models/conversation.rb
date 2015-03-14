class Conversation < ActiveRecord::Base
  belongs_to :user
  has_many :conversation_users
  has_many :users, through: :conversation_users
  validates :user_id, presence: true
end
