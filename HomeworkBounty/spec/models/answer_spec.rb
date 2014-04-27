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
		
	end
	it "should be able to find by user" do
			
	end
end
