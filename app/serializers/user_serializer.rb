class UserSerializer < ActiveModel::Serializer
  attributes :id, :phone, :first_name, :last_name, :filename
  # has_many :conversations, through: :conversation_users
end
