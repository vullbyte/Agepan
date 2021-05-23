class SearchesController < ApplicationController
  def search
    # userのサイドバー表示用(myuser, myfavorites)
    @myuser = current_user.id
    @my_user = User.find(@myuser)
    @myfavorites = Favorite.where(user_id: @my_user)
    
    @range = params[:range]
    if params[:range]=='1'
      @range = '1'
    else params[:range]=='2'
      @range = '2'
    end
      
    # search = params[:search]
    # 検索は部分選択しか使わないと判断したため、パラメータを指定
    search = "partial_match"
    word = params[:word]

    if @range == '1'
      @user = User.search(search,word)
    else
      @post = Post.search(search,word)
    end
  end
end
