class AlterPosts < ActiveRecord::Migration
  def self.up
  	rename_column("posts", "body", "content")
    change_column("posts", "author", :integer, :default => 0, :null => false)
    rename_column("posts", "author", "author_id")
    add_index("posts", "author_id")
  end

  def self.down
    
    remove_index("posts", "author_id")
    rename_column("posts", "content", "body")
    rename_column("posts", "author_id", "author")
    change_column("posts", "author", :string, :limit => 100, :default => 0,
                      :null => false)
  end
end
