class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comments = @post.post_comments.build(post_comment_params)
    @comments.user_id = current_user.id
    @post_comments = @post.post_comments
    if @comments.save
      render :index
    end
  end

  def destroy
    # @comment = PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    @post = Post.find(params[:post_id])
    @comment = PostComment.find(params[:id])
    @post_comments = @post.post_comments
    if @comment.destroy
      render :index
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id, :user_id)
  end
end
