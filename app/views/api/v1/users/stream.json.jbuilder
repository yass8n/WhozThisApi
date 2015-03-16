json.conversations @conversations do |conversation|
	json.title conversation.title
	json.id    conversation.id
	json.users conversation.users
end