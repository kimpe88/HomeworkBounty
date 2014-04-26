require 'spec_helper'

describe Question do
  before :each do
		@school_args = {:name => 'kth', :website => 'kth.se', :email_domain => '@kth.se'}
		@school = School.create!(@school_args)
		@user_args = {:username => 'test_user1', :email => 'test@kth.se', :password => 'password'}
		@user = @school.students.create!(@user_args)
		@user_args2 = {:username => 'test_user2', :email => 'test2@kth.se', :password => 'password2'}
		@user2 = @school.students.create!(@user_args2)
		@question = Question.create!({:title => 'Covariance of two functions', :body => 'Help me! I dont understand the question and how to put it into contex'})
		
	end
	it "should be searchable by title" do
		Question.find_by(:title => @question.title)
	end
	it "should be searchable by user" do
		@user.questions.create!(:title => 'räven raskar över isen', :body => 'Det var en gång')
		@user.questions.create!(:title => 'räven raskade över isen', :body => 'Räven sköts...')
		Question.where(:user_id => @user.username).should_not be_blank
	end
	it "should not allow empty fields" do
		expect {  Question.create!({:title => '', :body => 'test@kth.se more more mroe'}) }.to raise_error
		expect {  Question.create!({:title => 'The title', :body => ''}) }.to raise_error
	end
	
end
