class MessagesController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :new, :create]
  def index
    @pagy, @messages = pagy(Message.includes(:sender, :reciever).where(reciever_id: current_user.id).order(created_at: :desc), item: 3)
  end

  def new
    @chat_user = User.find(params[:chat_user_id])
    @messages = Message.where('sender_id = ? AND reciever_id = ?', current_user.id, @chat_user.id).or(Message.where('sender_id = ? AND reciever_id = ?', @chat_user.id, current_user.id)).order(created_at: :asc)
    @message = Message.new
    
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = 'メッセージを送信しました。'
      redirect_to message_new_path(chat_user_id: @message.reciever_id)
    else
      flash[:danger] = 'メッセージの送信に失敗しました。'
      redirect_to message_new_path(chat_user_id: @message.reciever_id)
    end
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:success] = 'メッセージを削除しました'
    redirect_back(fallback_location: message_new_path)
  end
  
  
  private
  
  def message_params
    params.require(:message).permit(:sender_id, :reciever_id, :content, :image)
  end
  
end
