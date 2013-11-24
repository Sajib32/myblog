class PostsController < ApplicationController

	def index
		list
		render('list')
	end

	def list
		@post = Post.new
		@posts = Post.order('posts.title ASC')
	end

	def new 
		@post = Post.new
	end

	def show
	end

	def create
	end

	def update
	end

	def destroy
	end 



end
