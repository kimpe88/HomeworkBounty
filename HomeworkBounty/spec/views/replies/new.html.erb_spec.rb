require 'spec_helper'

describe "replies/new" do
  before(:each) do
    assign(:reply, stub_model(Reply,
      :body => "MyString",
      :count => 1
    ).as_new_record)
  end

  it "renders new reply form" do
    @answer = Answer.last
		render
		
	
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", answer_reply_path(@answer), "post" do
      assert_select "input#reply_body[name=?]", "reply[body]"
      assert_select "input#reply_count[name=?]", "reply[count]"
    end
  end
end
