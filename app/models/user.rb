class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  has_many :conversations, through: :conversation_users
end
