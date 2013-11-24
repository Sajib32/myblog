class Comment < ActiveRecord::Base
  attr_accessible :post_id, :author, :author_email, :content,
  				  :status
  belongs_to :post
end
