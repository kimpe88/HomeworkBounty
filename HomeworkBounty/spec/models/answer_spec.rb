require 'spec_helper'

describe Answer do
  before :each do
		@school_args = {:name => 'kth', :website => 'kth.se', :email_domain => '@kth.se'}
		@school = School.create!(@school_args)
		@user_args = {:username => 'test_user1', :email => 'test@kth.se', :password => 'password'}
		@user = @school.students.create!(@user_args)
		@user_args2 = {:username => 'test_user2', :email => 'test2@kth.se', :password => 'password2'}
		@user2 = @school.students.create!(@user_args2)
		@question = @user.questions.create!({:title => 'Covariance of two functions', :body => 'Help me! I dont understand the question and how to put it into contex'})
		@question1 = @user.questions.create!({:title => 'Goat simalutor?', :body => 'Help me'})
		@answer = @question.answers.create!({:body => 'The first reponse', :author => @user.username})
		@answer = @question.answers.create!({:body => 'The second reponse', :author => @user2.username})
		@answer = @question1.answers.create!({:body => 'The second reponse', :author => @user2.username})
	end
	it "should be able to find by username" do
			@question.answers.find_by(:author => @user.username)
	end
	it "should be able to find all different answer" do
			@tmp_answers = @question.answers
			@tmp_answers1 = @tmp_answers[0]
			@tmp_answers2 = @tmp_answers[1]
			@tmp_answers1.author = @user.username
			@tmp_answers2.author = @user2.username			
	end
	it "should be able to find all different questions and their answer/answers" do
			@question.answers.length == 2
			@question1.answers.length == 1
	end
	it "should not allow too short passwords" do
		expect {@question.answers.create!({:body => 'The second reponse'}) }.to raise_error
		expect {@question.answers.create!({:author => @user.username}) }.to raise_error
	end
end
