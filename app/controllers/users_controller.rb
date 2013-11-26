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
		@user = User.find(params[:id]) if params[:id]
		@user = User.new if @user.nil?
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:notice] = "User successfully created."
			redirect_to(:action => 'list')
		else
			render('manage')
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:notice] = "User successfully updated."
			redirect_to(:action => 'list')
		else
			render('manage')
		end
	end
end
