class MessagesController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :new, :create]
  def index
    @pagy, @messages = pagy(Message.includes(:sender).where(reciever_id: current_user.id), item: 3)
  end

  def new
    @chat_user = User.find(params[:id])
    @messages = Message.where('sender_id = ? AND reciever_id = ?', current_user.id, @chat_user.id).or(Message.where('sender_id = ? AND reciever_id = ?', @chat_user.id, current_user.id)).order(created_at: :desc)
    @message = Message.new
    
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = 'メッセージを送信しました。'
      redirect_to :message_new
    else
      flash[:danger] = 'メッセージの送信に失敗しました。'
      redirect_to :message_new
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
