class DashboardController < ApplicationController
  # before_action :is_admin?

  def index
    @posts = Post.all
  end

  private

  def is_admin?
    unless current_user.admin
      flash[:notice] = "You are not authorized to perform this action blabla."
      redirect_to root_path
    end
  end
end
