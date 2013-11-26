class CategoriesController < ApplicationController

	def index
		list
		render('list')
	end

	def list
		@categories = Category.all
		@category = Category.find(params[:id]) if params[:id]
		@category = Category.new if @category.nil?
	end


	def create
		 # Instantiate a new object using form parameters
		@category = Category.new(params[:category])
    	 # Save the object
    	if @category.save
      	# If save succeeds, redirect to the list action
      		flash[:notice] = "Category created."
      		redirect_to(:action => 'list')
    	else
      	# If save fails, redisplay the form so user can fix problems
      		render('list')
    	end
	end

	def update
		@category = Category.find(params[:id])
    	if @category.update_attributes(params[:category])
			flash[:notice] = "Category updated."
      		redirect_to(:action => 'list')
    	else
      		render('list')
    	end
    end

	def destroy
		Category.find(params[:id]).destroy
		redirect_to(:action => 'list')
	end 
end