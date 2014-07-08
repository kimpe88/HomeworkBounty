require 'spec_helper'

describe Answer do
  before :each do
		@question1 = @user.questions_made.create!({:title => 'Goat simalutor?', :body => 'Help me'})
		@user2.answers_made.create!({:body => 'The second reponse again',:question => @question1._id})
	end
	it "should be able to find by username" do
			@question.answers.find_by(:author_to_answer_id => @user.username)
	end
	it "should be able to find all different answer" do
			@tmp_answers = @question.answers
			@tmp_answers1 = @tmp_answers[0]
			@tmp_answers2 = @tmp_answers[1]
			@tmp_answers1.author_to_answer = @user.username
			@tmp_answers2.author_to_answer = @user2.username
	end
	it "should be able to find all different questions and their answer/answers" do
			@question.answers.length.should eql(2)
			@question1.answers.length.should eql(1)
	end
	it "should not allow empty fields" do
		expect {@question.answers.create!({}) }.to raise_error
	end
end
