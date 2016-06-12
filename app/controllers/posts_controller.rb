class PostsController < ApplicationController
  before_action :load_post, only: [:show, :edit, :update, :destroy]

  def index
    respond_with(@posts = Post.all)
  end

  def new
    respond_with(@post = Post.new)
  end

  def show
    respond_with @post
  end

  def create
    respond_with(@post = Post.create(post_params))
  end

  def edit
  end

  def update
    @post.update(post_params)
    respond_with @post
  end

  def destroy
    respond_with(@post.destroy)
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
