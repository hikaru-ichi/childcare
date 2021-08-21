class ResponsesController < ApplicationController
  def new
  end

  def create
    @response = Response.new(response_params)

    if @response.save
      flash[:success] = '回答を送信しました。'
      redirect_to :post
    else
      flash[:danger] = '回答の送信に失敗しました。'
      redirect_to :post, flash: { error: @response.errors.full_messages }
    end
  end

  def destroy
    @response = Response.find(params[:response_id])
    @response.destroy
    flash[:success] = '回答を削除しました'
    redirect_back(fallback_location: @post)
  end
  
  
  private
  
  def response_params
    params.require(:response).permit(:user_id, :post_id, :content, :image)
  end
end
