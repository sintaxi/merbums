require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Topics, "index action" do
  before(:each) do
    dispatch_to(Topics, :index)
  end
end