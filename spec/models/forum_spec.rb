require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module ForumSpecHelper
  
  def valid_forum_attributes
    {
      :name => 'Hot Sause',
      :description => "discussion on favorite sauses and sause like substances"
    }
  end

  def permalink
    "hot-sause"
  end
    
  def description_html
    "<p>discussion on favorite sauses and sause like substances</p>"
  end
  
end

describe Forum do
  include ForumSpecHelper
  
  before(:each) do
    @forum = Forum.new
  end

  it "should be valid" do
    @forum.attributes = valid_forum_attributes
    @forum.should be_valid
  end

  it "should require name" do
    @forum.attributes = valid_forum_attributes.except(:name)
    @forum.should_not be_valid
  end
  
  it "should require description" do
    @forum.attributes = valid_forum_attributes.except(:description)
    @forum.should_not be_valid
  end
  
  it "should create permalink" do
    @forum.attributes = valid_forum_attributes
    @forum.create_permalink
    @forum.permalink.should == permalink
  end
  
  it "should convert description to html" do
    @forum.attributes = valid_forum_attributes
    @forum.formatted_description
    @forum.description_html.should == description_html
  end
  
end