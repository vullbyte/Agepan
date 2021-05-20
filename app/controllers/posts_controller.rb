class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  # 投稿データの保存
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    # userのサイドバー表示用(myuser, myfavorites)
    @myuser = current_user.id
    @my_user = User.find(@myuser)
    @myfavorites = Favorite.where(user_id: @my_user)
    
    
    @user = User.find(current_user.id)
    @favorites = Favorite.where(user_id: @user)
    # kaminari機能でページ指定をしつつ一覧取得
    @posts = Post.page(params[:page]).reverse_order
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  def show
    # userのサイドバー表示用(myuser, myfavorites)
    @myuser = current_user.id
    @my_user = User.find(@myuser)
    @myfavorites = Favorite.where(user_id: @my_user)
    
    @user = User.find(current_user.id)
    @favorites = Favorite.where(user_id: @user)
    
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.all
    @user = User.find(@post.user_id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :tag_list, { image: [] }, :user_id)
  end
  def user_params
    params.require(:user).permit(:name, :profile_image, :profile)
  end
end
