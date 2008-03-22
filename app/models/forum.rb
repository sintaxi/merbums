class Forum < ActiveRecord::Base
  
  has_many :topics
  has_many :posts
  
  before_save :formatted_description
  
  def formatted_description
    write_attribute(:description_html, RedCloth.new(description).to_html  )
  end
  
end