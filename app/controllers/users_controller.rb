class UsersController < ApplicationController
  def index
    @users = User.all
    # @user = User.find(params[:id])
  end

  def show
    # userのサイドバー表示用(myuser, myfavorites)
    @myuser = current_user.id
    @my_user = User.find(@myuser)
    @myfavorites = Favorite.where(user_id: @my_user)

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

  def favorites
    @user = User.find(params[:user_id])
    @favorites = Favorite.where(user_id: @user)
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :profile)
  end
end
