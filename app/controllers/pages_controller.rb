class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :contact, :news]

	def home
	end

	def about
	end

	def contact
	end

  def news
    @posts = Post.all
  end
end
