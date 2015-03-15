class ConversationUserSerializer < ActiveModel::Serializer
  attributes :id, :phone, :conversation_id, :user_id
end
