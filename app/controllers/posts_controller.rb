class PostsController < ApplicationController
  def index
    if params[:keyword]
      selection = params[:keyword]
      @pagy, @posts = pagy(Post.sort(selection))
    else
      @pagy, @posts = pagy(Post.all.order(created_at: :desc))
    end
  end

  def show
  end

  def new
    @categories = Category.all
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = 'お悩みを投稿しました。'
      redirect_to :root
    else
      flash[:danger] = 'お悩み投稿に失敗しました。'
      redirect_to :new_post
    end
  end

  def destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id, :category_id, :title, :content, :image)
  end
  
end
