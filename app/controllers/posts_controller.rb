class PostsController < ApplicationController
  def index
    selection = params[:keyword] || "new"
    search_keyword = params[:search_keyword]
    if search_keyword.present?
       @posts = Post.includes(:category).references(:category).search(search_keyword)

      if selection == "new"
        @pagy, @posts = pagy_array(@posts.sort{|a, b| b[:created_at] <=> a[:created_at]})
      elsif selection == "old"
        @pagy, @posts = pagy_array(@posts.sort{|a, b| a[:created_at] <=> b[:created_at]})
      elsif selection == "category"
        @pagy, @posts = pagy_array(@posts.sort{|a, b| a[:category_name] <=> b[:category_name]})
      end
      
    else
      @pagy, @posts = pagy(Post.sort(selection))
    end
  end

  def show
    @post = Post.find(params[:id])
    @responses = @post.responses.includes([:user, :post]).order(created_at: :desc)
    @response = Response.new
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
      redirect_to :new_post, flash: { error: @post.errors.full_messages }
    end
  end

  def destroy
  end

  def new_search
    @categories = Category.all
  end
  
  def search
    @pagy, @posts = pagy(Post.includes(:category).references(:category).search(params[:search_keyword]))
    @search_keyword = params[:search_keyword]
    redirect_to root_path(search_keyword: @search_keyword)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id, :category_id, :title, :content, :image)
  end
  
end
