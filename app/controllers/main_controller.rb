class MainController < ApplicationController
  
  include MainHelper 

  before_filter :set_all_categories

  def index
    list
    render(:action => 'list')
  end

  def list
    @all_categories = Category.new
    @all_categories = Category.find(:all, :order => 'name ASC')
    @posts = Post.find(:all,
    :joins => [:author, :categories],
    :conditions => ["status='published'",
      params[:id]])

  end

  def category
    @posts = Post.find(:all,
    :joins => [:author, :categories],
    :conditions => ["status='published' AND categories.id = ?",
      params[:id]])
render('list')
  end

  def archive
  end

  def view_post
    @post = Post.find(params[:id])
    @comment = Comment.new
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

  private #-----

  def set_all_categories
    @all_categories = Category.find(:all, :order => 'name ASC')
  end
end