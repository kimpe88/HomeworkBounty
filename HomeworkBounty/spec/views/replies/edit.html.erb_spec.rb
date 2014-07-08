require 'spec_helper'

describe "replies/edit" do
  before(:each) do
    @reply = assign(:reply, stub_model(Reply,
      :body => "MyString",
      :count => 1
    ))
  end

  it "renders the edit reply form" do
    render
  end
end
