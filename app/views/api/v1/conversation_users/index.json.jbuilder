json.array!(@conversation_users) do |conversation_user|
  json.extract! conversation_user, :id, :user_id, :conversation_id
  json.url conversation_user_url(conversation_user, format: :json)
end
