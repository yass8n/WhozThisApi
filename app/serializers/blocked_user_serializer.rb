class BlockedUserSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :blocked_id
end
