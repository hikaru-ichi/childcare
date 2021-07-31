class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  def show
    @user = User.find(params[:id])
    @pagy, @children = pagy(@user.children, items: 3)
  end

  def new
    @user = User.new
    @children = @user.children.build
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :birth, :gender, :password, :password_confirmation, children_attributes: [:child_gender, :child_birth, :destroy, :id])
  end
  
end
