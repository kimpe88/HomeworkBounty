require 'spec_helper'

describe Tag do
  it "should be able to find by tag name" do
			Tag.find_by(:name => @tag.name)
	end
	it "should be able to find all questions with tag name" do
			@tags = @question.tags
			@tags.length.should eql(2)
	end
	it "should not allow empty fields" do
		expect {@question.tags.create!({}) }.to raise_error
	end
end
