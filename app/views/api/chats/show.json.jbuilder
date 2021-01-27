json.array! @chats do |chat|
  json.sentence chat.sentence
  json.created_at chat.created_at.strftime("%Y年%m月%d日 %H時%M分")
  json.user_name chat.user.name
  json.image @partner.image
  json.id chat.id
  json.current_user_id current_user.id
  json.user_id chat.user.id 
end