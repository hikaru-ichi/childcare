class ChildrenController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @child = current_user.children.build
  end

  def create
    @user = User.find(params[:id])
    @child = current_user.children.build(child_params)
    if @child.save
      flash[:success] = 'お子様情報を追加しました'
      redirect_to @user
    else
      flash.now[:danger] = 'お子様情報追加に失敗しました。'
      render :new
    end
  end
  
  
  private
  
  def child_params
    params.require(:child).permit(:child_gender, :child_birth)
  end
end