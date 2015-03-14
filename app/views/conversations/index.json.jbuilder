json.array!(@conversations) do |conversation|
  json.extract! conversation, :id, :title, :user_id
  json.url conversation_url(conversation, format: :json)
end
