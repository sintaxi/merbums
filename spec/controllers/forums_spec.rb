require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Forums, "index action" do
  before(:each) do
    dispatch_to(Forums, :index)
  end
end