class Topic < ActiveRecord::Base
  
  has_many :posts, :order => :updated_at
  belongs_to :forum, :counter_cache => true
  belongs_to :user, :counter_cache => true
  
  validates_presence_of :title,:body
  
  after_create  :add_first_post
  before_save   :create_permalink
  
  attr_accessor :body
  
  def to_param
    permalink
  end
  
  def self.find_by_param(*args)
    find_by_permalink *args
  end

  def create_permalink
    self.permalink = self.title.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '-') if permalink.blank?
  end
  
  def add_first_post
    self.posts.create({ :user_id => user.id,
                        :body => body,
                        :topic_id => id,
                        :forum_id => forum.id})
  end
  
end