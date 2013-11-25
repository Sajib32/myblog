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
		@user_list = get_user_list
	end

	def show
		@post = Post.find(params[:id])
	end

	def create
		post_params = params[:post]
		author_id = post_params.delete(:author_id)
		 # Instantiate a new object using form parameters
    	 @post = Post.new(post_params)
    	 @post.author = User.find(author_id)
    	 # Save the object
    	if @post.save
      	# If save succeeds, redirect to the list action
      		flash[:notice] = "Post created."
      		redirect_to(:action => 'list')
    else
      	# If save fails, redisplay the form so user can fix problems
      		@user_list = get_user_list
      		render('new')
    	end
	end

	def edit
		@post = Post.find(params[:id])
		@user_list = get_user_list
	end

	def update
		post_params = params[:post]
		author_id = post_params.delete(:author_id)
		# Find object using form parameters
    	@post = Post.find(params[:id])
    	 @post.author = User.find(author_id) if @post.author_id != author_id
    	# Update the object
    	if @post.update_attributes(post_params)
      	# If update succeeds, redirect to the list action
      		flash[:notice] = "Post updated."
      		redirect_to(:action => 'list')
    	else
      	# If save fails, redisplay the form so user can fix problems
      		@user_list = get_user_list
      		render('edit')
    end
end

	def destroy
		Post.find(params[:id]).destroy
		redirect_to(:action => 'list')
	end 

	private

	def get_user_list
		return User.find(:all, :order => 'last_name ASC')
					.collect {|user| [user.full_name, user.id]}
	end
end
