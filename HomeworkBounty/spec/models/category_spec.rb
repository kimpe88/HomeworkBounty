require 'spec_helper'

describe Category do
  it "should be able to find by category name" do
			Category.find_by(:name => @category.name)
	end
	it "should be able to find all questions with category name" do
	
			@question2 = @user.questions_made.create!({:title => 'Rävearn',:body => 'Men ', :question_category => @category._id,:tags => [@tag3]}) 
			@tags = @category.questions_under_category
			@tags.length.should eql(2)
	end
	it "should not allow empty fields" do
		expect {@question.tags.create!({}) }.to raise_error
	end
end
