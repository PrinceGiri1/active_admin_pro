class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user  # Assuming you have authentication in place

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      # Handle validation errors
      render 'posts/show'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
