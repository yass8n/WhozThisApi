class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :created_at

  # belongs_to :user
  # has_many :conversation_users
  # has_many :users, through: :conversation_users
end
