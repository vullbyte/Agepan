class Admin::PostsController < ApplicationController
  def index
    # kaminari機能でページ指定をしつつ一覧取得
    @posts = Post.page(params[:page]).reverse_order
    @posts = Post.tagged_with(params[:tag_name].to_s) if params[:tag_name]
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.all
    @user = User.find(@post.user_id)
    @favorites = Favorite.where(user_id: @user)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :tag_list, { image: [] }, :user_id)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :profile)
  end
end
