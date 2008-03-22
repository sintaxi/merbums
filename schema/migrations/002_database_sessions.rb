class DatabaseSessions < ActiveRecord::Migration
  def self.up
		create_table :sessions do |t|
		  t.text :session_id
		  t.text :data
		end
  end

  def self.down
		drop_table :sessions
  end
end



