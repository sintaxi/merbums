class AddPermalinksMigration < ActiveRecord::Migration
  def self.up
    add_column :forums, :permalink, :string
    add_column :topics, :permalink, :string
    
    add_index :forums,  :permalink
    add_index :topics,  :permalink
  end

  def self.down
    remove_column :forums,  :permalink
    remove_column :topics,  :permalink
  end
end
