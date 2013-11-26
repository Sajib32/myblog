class Categorization < ActiveRecord::Base
  self.table_name = "categories_posts"	
  attr_accessible :category_id, :post_id

  belongs_to :category
  belongs_to :post
end
