class Comment < ActiveRecord::Base
  attr_accessible :post_id, :author, :author_email, :content,
  				  :status
  belongs_to :post, :counter_cache => true

  validates_presence_of :author, :author_email, :content, :status
  validates_length_of :author, :within => 3..25
  validates_inclusion_of :status, :in => %w{new approved spam}
  validates_format_of :author_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

end
