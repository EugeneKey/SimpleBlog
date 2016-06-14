class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_post, only: [:show, :edit, :update, :destroy]
  before_action :load_comments, :build_comment, only: :show

  def index
    respond_with(@posts = Post.publishing.paginate(page: params[:page], per_page: 5))
  end

  def new
    respond_with(@post = Post.new)
  end

  def show
    respond_with @post
  end

  def create
    respond_with(@post = Post.create(post_params.merge(user: current_user)))
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

  def user_posts
    respond_with(@posts = Post.user_posts(current_user))
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :publish)
  end

  def load_comments
    @comments = @post.comments.find_each
  end

  def build_comment
    @comment = @post.comments.build
  end

  def interpolation_options
    if @post.publish
      { unpublishing_post: 'And successfully published.' }
    else
      { unpublishing_post: 'But not publishing.' }
    end
  end
end
