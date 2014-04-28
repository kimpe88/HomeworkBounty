require 'spec_helper'
describe "Questions" do
	before :each do
		host! "localhost:3000"
	end
  describe "GET /questions" do
    it "works! (now write some real specs)" do
      get questions_path
      puts response
      response.status.should be(200)
    end
  end
end
