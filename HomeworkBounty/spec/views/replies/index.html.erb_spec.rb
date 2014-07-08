require 'spec_helper'

describe "replies/index" do
  before(:each) do
    assign(:replies, [
      stub_model(Reply,
        :body => "Body",
        :count => 1
      ),
      stub_model(Reply,
        :body => "Body",
        :count => 1
      )
    ])
  end

  it "renders a list of replies" do
    #render
  end
end
