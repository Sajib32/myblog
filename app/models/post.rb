class Post < ActiveRecord::Base
  attr_accessible :title, :content, :author_id, :status, :comments_count

  belongs_to :author, :class_name => 'User', 
  			 :foreign_key => 'author_id'

  has_many :comments, :order => 'created_at ASC', :dependent => :destroy
  has_many :approved_comments, :class_name => 'Comment', 
  		   :conditions => "status = 'approved'"
  has_many :recent_posts, :class_name => 'Post', :order => 
  			'created_at ASC', :limit => 5

  has_many :categorizations

  has_many :categories, :through => :categorizations

  #def approved_comments
  	#self.comments.find(:all, :conditions => "status = 'approved")
  #end

end
