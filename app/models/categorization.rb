class Categorization < ActiveRecord::Base
  set_table_name "categories_posts"	
  attr_accessible :category_id, :post_id

  belongs_to :category
  belongs_to :post
end
