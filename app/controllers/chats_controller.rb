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
    @chat = Chat.new(chat_params)
    if @chat.save
      respond_to do |format|
        format.json
      end
    else
      @chats = chats.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :show
    end
  end

  private
  def chat_params
    params.require(:chat).permit(:sentence, :user_id, :partner_id)
  end
end
