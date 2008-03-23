class ForumMigration < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.string :name
      t.string :description
      t.text :description_html
      t.integer :position 
      t.integer :posts_count, :default => 0
      t.integer :topics_count, :default => 0 

      t.timestamps
    end    
  end

  def self.down
    drop_table :forums
  end
end
