class UserCounterCaches < ActiveRecord::Migration
  def self.up
    add_column :users, :topics_count, :integer
    add_column :users, :posts_count, :integer
  end
  
  def self.down
    
    remove_column :users, :topics_count
    remove_column :users, :posts_count
  end
end