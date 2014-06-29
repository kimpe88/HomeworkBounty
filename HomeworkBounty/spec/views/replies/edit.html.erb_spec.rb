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

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", reply_path(@reply), "post" do
      assert_select "input#reply_body[name=?]", "reply[body]"
      assert_select "input#reply_count[name=?]", "reply[count]"
    end
  end
end
