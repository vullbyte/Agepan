class Admin::UsersController < ApplicationController
  def index
    @users = User.all
    # @user = User.find(params[:id])
  end

  def show
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :profile)
  end
end
