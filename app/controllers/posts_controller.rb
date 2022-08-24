class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :is_admin?

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save
    if @post.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @post.update(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def is_admin?
    unless current_user.admin
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end
