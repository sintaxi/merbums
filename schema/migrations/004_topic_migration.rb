class TopicMigration < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :title 
      t.boolean :sticky, :default => false
      t.boolean :locked, :default => false 
      t.integer :posts_count, :default => 0

      t.timestamps
      
      t.integer :forum_id 
      t.integer :user_id
    end    
  end

  def self.down
    drop_table :topics
  end
end
