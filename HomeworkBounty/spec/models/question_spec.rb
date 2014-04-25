require 'spec_helper'

describe Question do
  before :each do
		@question = Question.create!({:title => 'Covariance of two functions', :body => 'Help me! I dont understand the question and how to put it into contex'})
	end
	it "should be searchable by title" do
		Question.find_by(:title => @question.title)
	end
	it "should not allow empty fields" do
		expect {  Question.create!({:title => '', :body => 'test@kth.se more more mroe'}) }.to raise_error
		expect {  Question.create!({:title => 'The title', :body => ''}) }.to raise_error
	end
	
end
