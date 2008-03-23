class Forum < ActiveRecord::Base
  
  has_many :topics
  has_many :posts
  
  before_save :formatted_description
  before_save :create_permalink
  
  def to_param
    permalink
  end
  
  def self.find_by_param(*args)
    find_by_permalink *args
  end
  
  def create_permalink
    self.permalink = self.name.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '-') if permalink.blank?
  end
  
  def formatted_description
    write_attribute(:description_html, RedCloth.new(description).to_html  )
  end
  
end