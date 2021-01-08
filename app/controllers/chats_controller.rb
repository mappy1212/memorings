class ChatsController < ApplicationController
  def index
    @my_chats = current_user.chats
    @chat_partners = User.where.not(id:current_user.id)#自分以外
  end
  
  def show
    @chat = Chat.new
    @partner = User.find(params[:id])
    @chats_by_myself = Chat.where(user_id: current_user.id,partner_id: @partner.id)
    @chats_by_other = Chat.where(user_id: @partner.id,partner_id: current_user.id)
    @chats = @chats_by_myself.or(@chats_by_other)#リレーションオブジェクト達を結合する
    @chats = @chats.order(:created_at)
    
  end

  def create
    Chat.create(chat_params)
  end

  private
  def chat_params
    params.require(:chat).permit(:sentence, :user_id, :partner_id)
  end
end
