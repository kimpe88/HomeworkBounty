require 'spec_helper'
describe Question do
	before :each do
		visit '/questions'
		@question = @user.questions_made.create!({:title => 'My question', :body => 'Do you know?'})
	end
	it "should be able to view questions" do
		page.should have_content('Latest question')
	end

	it "should not be able to post without logging in" do
		click_link('New Question')
		page.should have_content('You need to sign in or sign up')
	end

	it "should be able to post question after logging in" do
		visit '/questions/'
		click_link 'Sign in'
		fill_in 'user_username', :with => @user_args[:username]
		fill_in 'user_password', :with => @user_args[:password]
		click_button 'Sign in'
		click_link 'New Question'
		page.should have_selector("input[type=submit][value='Create Question']")
	end

	it "should be able to edit own posts" do
		visit '/questions/' + @question[:id]
		click_link 'Sign in'
		fill_in 'user_username', :with => @user_args[:username]
		fill_in 'user_password', :with => @user_args[:password]
		click_button 'Sign in'
		page.should have_content('Edit')
	end

	it "should not be able to edit other user's posts" do
		new_question = Question.create!({:title => 'hello', :body => 'see this'})
		@user2.questions_made << new_question
		visit '/questions/' + new_question[:id]
		click_link 'Sign in'
		fill_in 'user_username', :with => @user_args[:username]
		fill_in 'user_password', :with => @user_args[:password]
		click_button 'Sign in'
		page.should_not have_content('Edit')
	end

	it "should be able to view specific post without logging in" do
		visit '/questions/' + @question[:id]
		page.should have_content(@question[:title])
	end

end
