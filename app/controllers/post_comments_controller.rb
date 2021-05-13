class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.post_comments.build(post_comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render :index
    end
  end

  def destroy
    # @comment = PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    @comment = PostComment.find(params[:id])
    if @comment.destroy
      render :index
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id, :user_id)
  end
end
