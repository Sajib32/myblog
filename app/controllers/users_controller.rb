class UsersController < ApplicationController

	layout "staff"

	def index
		list
		render('list')
	end

	def list
		@users = User.all
	end

	def manage
		list
		if request.get? && params[:id].blank? #new
			@user = User.new
		elsif request.post? && params[:id].blank?
			@user = User.new(params[:user])
		  if @user.save
			flash[:notice] = "User successfully created."
			redirect_to(:action => 'list')
		  else
			render('manage')
		  end
		elsif request.get? && !params[:id].blank? #edit
			@user = User.find(params[:id])	
		elsif request.post? && !params[:id].blank? #update 	
			@user = User.find(params[:id])
		   if @user.update_attributes(params[:user])
			flash[:notice] = "User successfully updated."
			redirect_to(:action => 'list')
		   else
			render('manage')
		   end
		end
	end

	def delete
		User.find(params[:id]).destroy
		flash[:notice] = "User successfully deleted."
		redirect_to(:action => 'list')
	end
end
