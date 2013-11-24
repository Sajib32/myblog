class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name, :limit => 50, :null => false
      t.string :short_name, :limit => 30, :null => false
      t.string :description, :null => false
      t.timestamps
    end
    create_table :categories_posts, :id => false do |t|
      t.integer :category_id, :null => false
      t.integer :post_id, :null => false
      t.timestamps
	end

	add_index("categories_posts", "category_id")
	add_index("categories_posts", "post_id")
	remove_column("posts", "category")
  end
  
  def self.down
  	drop_table :categories
  	drop_table :categories_posts
  	add_column("posts", "category", :string, :limit => 20, 
  					:default => "", :null => false)
  end
end
