class PostsController < ApplicationController

	include PostsHelper

	layout "staff"

	def index
		list
		render('list')
	end

	def list
		@post = Post.new
		@posts = Post.order('posts.created_at DESC')
	end

	def new 
		@post = Post.new
		@user_list = get_user_list
		@all_categories = get_all_categories
	end

	def show
		# this action will preview the public view of the post
		@post = Post.find(params[:id])
		#render(:controller => 'main', :action => 'view_post')
		render(:template => 'shared/view_post', :layout => 'application')
	end
	alias :view_post :show

	def create
		post_params = params[:post]
		author_id = post_params.delete(:author_id)
		@all_categories = get_all_categories
		checked_categories = get_categories_from(params[:categories])
		removed_categories = @all_categories - checked_categories
		 # Instantiate a new object using form parameters
    	 @post = Post.new(post_params)
    	 @post.author = User.find(author_id)

    	 # Save the object
    	if @post.save
    		 checked_categories.each {|cat| @post.categories << cat if 
    	 !@post.categories.include?(cat)}
    	  	 removed_categories.each {|cat| @post.categories.delete(cat) if 
    	 @post.categories.include?(cat)}
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
		@all_categories = get_all_categories
	end

	def update
		post_params = params[:post]
		author_id = post_params.delete(:author_id)
		@all_categories = get_all_categories
		checked_categories = get_categories_from(params[:categories])
		removed_categories = @all_categories - checked_categories
		# Find object using form parameters
    	@post = Post.find(params[:id])
    	 @post.author = User.find(author_id) if @post.author_id != author_id
    	# Update the object
    	if @post.update_attributes(post_params)
      	# If update succeeds, redirect to the list action
     		checked_categories.each {|cat| @post.categories << cat if 
    	 !@post.categories.include?(cat)}
    	  	 removed_categories.each {|cat| @post.categories.delete(cat) if 
    	 @post.categories.include?(cat)}
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

	def get_all_categories
		return Category.find(:all, :order => 'name ASC')
	end

	def get_categories_from(cat_list)
		cat_list = [] if cat_list.blank?
		return cat_list.collect {|cid| Category.find_by_id(cid.to_i)}.compact
	end
end
