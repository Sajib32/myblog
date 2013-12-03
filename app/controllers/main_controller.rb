class MainController < ApplicationController
  
  include MainHelper 

  def index
    list
    render(:action => 'list')
  end

  def list
    @posts = Post.find(:all,
        :conditions => "status = 'published' ",
        :order => 'created_at DESC')
  end

  def category
  end

  def archive
  end

  def view_post
    @post = Post.find(params[:id])
    @comment = Comment.new(params[:comment])
    render(:template => 'shared/view_post', :layout => 'application')
  end

  def add_comment
    @post = Post.find(params[:id])
    @comment = Comment.new(params[:comment])
    @comment.status = 'new'
    @comment.post = @post 
    
    if @comment.save 
      flash[:notice] = 'Your comment was submitted successfully.'
      redirect_to(:action => 'view_post', :id => @post.id)
    else
      flash[:notice] = 'Your comment was not submitted successfully.'
      render(:template => 'shared/view_post', :layout => 'application')
    end
  end

end