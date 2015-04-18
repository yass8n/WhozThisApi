json.conversations conversations do |conversation|
	json.title       conversation.title
	json.id          conversation.id
	json.created_at  conversation.created_at

	json.users conversation.users.each  do |user| 
	json.id          user.id
	json.first_name  user.first_name
    json.last_name   user.last_name
    json.phone       user.phone
	json.fake_id     user.get_convo_fake_id(conversation.id)
	json.color       user.get_convo_color(conversation.id)     
	end
end