class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    if is_admin?
      @post = Post.new
    else
      flash.now[:notice] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end

  def create
    if is_admin?
      @post = Post.new(post_params)
      @post.user = current_user
      @post.save
      if @post.save
        redirect_to post_path(@post)
      else
        render :new, status: :unprocessable_entity
      end
    else
      not_authorized
    end
  end

  def show
    if is_admin?
      not_authorized
    end
  end

  def edit
    if is_admin?
      not_authorized
    end
  end

  def update
    if is_admin?
      @post.update(post_params)
      if @post.save
        redirect_to post_path(@post)
      else
        render :new, status: :unprocessable_entity
      end
    else
      not_authorized
    end
  end

  def destroy
    if is_admin?
      @post.destroy
      redirect_to posts_path, status: :see_other
    else
      not_authorized
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def is_admin?
    signed_in? ? current_user.admin : false
  end

  def not_authorized
    flash[:notice] = "You are not authorized to perform this action."
    redirect_to root_path
  end
end
