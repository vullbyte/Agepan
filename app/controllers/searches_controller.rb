class SearchesController < ApplicationController
  def search
    @range = params[:range]
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
