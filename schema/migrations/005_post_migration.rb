class PostMigration < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.text :body
      t.text :body_html
      
      t.timestamps
      
      t.integer :topic_id 
      t.integer :forum_id 
      t.integer :user_id
    end    
  end

  def self.down
    drop_table :posts
  end
end
