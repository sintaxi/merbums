require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Attachments, "index action" do
  before(:each) do
    dispatch_to(Attachments, :index)
  end
end