class Topic < ActiveRecord::Base
  has_many :posts
  belongs_to :forum, :counter_cache => true
  belongs_to :user, :counter_cache => true
  
  validates_presence_of :title,:body
  
  after_create  :add_first_post
  
  attr_accessor :body
  
  def add_first_post
    self.posts.create({ :user_id => user.id,
                        :body => body,
                        :topic_id => id,
                        :forum_id => forum.id})
  end
  
end