require 'spec_helper'

describe "Replies" do
  describe "GET /replies" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
			get answer_replies_path(@answer)
      response.status.should be(200)
    end
  end
end
