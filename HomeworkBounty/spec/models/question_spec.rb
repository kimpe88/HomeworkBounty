require 'spec_helper'

describe Question do
	it "should be searchable by title" do
		Question.find_by(:title => @question.title)
	end
	it "should be searchable by user" do
		@user.questions_made.create!(:title => 'räven raskar över isen', :body => 'Det var en gång')
		@user.questions_made.create!(:title => 'räven raskade över isen', :body => 'Räven sköts...')
		@user.questions_made.should_not be_blank
	end
	it "should not allow empty fields" do
		expect {  Question.create!({:title => '', :body => 'test@kth.se more more mroe'}) }.to raise_error
		expect {  Question.create!({:title => 'The title', :body => ''}) }.to raise_error
	end
	
end
