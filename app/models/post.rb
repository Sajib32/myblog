class Post < ActiveRecord::Base
  attr_accessible :title, :content, :author_id, :status

  belongs_to :author, :class_name => 'User', 
  			 :foreign_key => 'author_id'

  has_many :comments, :order => 'created_at ASC', :dependent => :destroy
 
  has_many :recent_posts, :class_name => 'Post', :order => 
  			'created_at ASC', :limit => 5

  has_many :categorizations

  has_many :categories, :through => :categorizations

end