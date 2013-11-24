class User < ActiveRecord::Base
  attr_accessible :username, :hashed_password, :first_name, 
  				  :last_name, :email, :display_name, :user_level

  has_many :posts, :foreign_key => 'author_id',
  		   :order => 'created_at ASC'  
end
