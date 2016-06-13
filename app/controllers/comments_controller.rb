class CommentsController < ApplicationController
  before_action :load_post, only: [:create]
  before_action :load_comment, except: [:create]

  respond_to :js

  def create
    respond_with(@comment = @post.comments.create(comment_params))
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    respond_with(@comment.destroy)
  end

  private

  def load_post
    @post = Post.find(params[:post_id])
  end

  def load_comment
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
