class UsersController < ApplicationController
  def index
    @users = User.all
    # @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    
    # favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    # @favorite_list = Post.find(favorites)     # postsテーブルから、お気に入り登録済みのレコードを取得
    @favorites = Favorite.where(user_id: @user)
  
  end
  
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :profile)
  end
end
