class UsersController < ApplicationController
  def index
    @users = User.all
    # @user = User.find(params[:id])
  end

  def show
    # 自分のサイドバー表示のため、見たいユーザーとは別に変数を用意(myuser, myfavorites)
    @myuser = current_user.id
    @my_user = User.find(@myuser)
    @myfavorites = Favorite.where(user_id: @my_user)

    @user = User.find(params[:id])
    @posts = @user.posts

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
  
  # 退会画面
  def withdrawal
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  # 管理者からは物理的に排除(よほどのことがない限り排除は)
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :profile)
  end
end
