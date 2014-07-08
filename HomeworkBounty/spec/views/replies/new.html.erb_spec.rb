require 'spec_helper'

describe "replies/new" do
  before(:each) do
    assign(:reply, stub_model(Reply,
      :body => "MyString",
      :count => 1
    ).as_new_record)
  end

  it "renders new reply form" do
		render
  end
end
