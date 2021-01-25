class Api::ChatsController < ApplicationController
  def show
    # ルーティングでの設定によりparamsの中にgroup_idというキーでグループのidが入るので、これを元にDBからグループを取得する
    chats = current_user.chats.where(partner_id:params[:id]) 
    # ajaxで送られてくる最後のメッセージのid番号を変数に代入
    last_chat_id = params[:id]
    # 取得したグループでのメッセージ達から、idがlast_message_idよりも新しい(大きい)メッセージ達のみを取得
    @chats = chats.where("id > ?", last_chat_id)
  end
end