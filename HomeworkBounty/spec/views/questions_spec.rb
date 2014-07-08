require 'spec_helper'
describe Question do
	before :each do
		visit '/questions'
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

	#Since answer is only made from within question so far
	it "should see answers to question when not logged in" do
		visit '/questions/' + @question[:id]
		answer_elements = page.all('.answer_element_wrapper')
		answer_elements[1].should have_content("test answer")
	end
	
	it "should be able to post answer when logged in" do
		visit '/questions/' + @question[:id]
		click_link 'Sign in'
		fill_in 'user_username', :with => @user2_args[:username]
		fill_in 'user_password', :with => @user2_args[:password]
		click_button 'Sign in'
		click_link 'Answer question'
		fill_in 'answer_body', :with => "test answer1"
		click_button 'New answer'
		page.should have_content('test answer1')
	end
	
	it "should not be able to post answer when not logged in" do
		visit '/questions/' + @question[:id]
		click_link 'Answer question'
		fill_in 'answer_body', :with => "test answer1"
		click_button 'New answer'
		page.should have_content('You need to sign in or sign up before continuing')
	end
	
	it "should be possible to edit own answer when logged in" do
		visit '/questions/' + @question[:id]
		click_link 'Sign in'
		fill_in 'user_username', :with => @user2_args[:username]
		fill_in 'user_password', :with => @user2_args[:password]
		click_button 'Sign in'
		find('.answer_body', :text =>'test answer2').should have_content("Edit")
	end	
	
	it "should not be possible to edit other users answers" do
		visit '/questions/' + @question[:id]
		click_link 'Sign in'
		fill_in 'user_username', :with => @user_args[:username]
		fill_in 'user_password', :with => @user_args[:password]
		click_button 'Sign in'
		find('.answer_body', :text =>'test answer2').should_not have_content("Edit")
		#find('.posted_by', :text => 'auto_user2').find(:xpath, '..').find('.answer_body', :text =>'test answer').should_not have_content("Edit")
	end
	
	#Since replies is only made from within question so far
	it "should see replies to answer when not logged in" do
		visit '/questions/' + @question[:id]
		reply_elements = page.all('.reply_body')
		reply_elements[0].should have_content("test reply")
	end
	
	it "should be able to post reply when logged in", :js => true do
		visit '/questions/' + @question[:id]
		click_link 'Sign in'
		fill_in 'user_username', :with => @user2_args[:username]
		fill_in 'user_password', :with => @user2_args[:password]
		click_button 'Sign in'
		click_link 'Reply'
		fill_in 'reply_body', :with => "test replying for the first time"
		click_button 'New reply'
		page.should have_content('test replying for the first time')
	end
	
	it "should not be able to post reply when not logged in" do
		visit '/questions/' + @question[:id]
		page.should_not have_content('Reply')
	end
	
	it "should be able to post reply when logged in" do
		visit '/questions/' + @question[:id]
		click_link 'Sign in'
		fill_in 'user_username', :with => @user2_args[:username]
		fill_in 'user_password', :with => @user2_args[:password]
		click_button 'Sign in'
		find('.reply_body', :text =>'test reply').should have_content("Edit")
	end	
	
	it "should be able to post reply when logged in" do
		visit '/questions/' + @question[:id]
		click_link 'Sign in'
		fill_in 'user_username', :with => @user_args[:username]
		fill_in 'user_password', :with => @user_args[:password]
		click_button 'Sign in'
		find('.reply_body', :text =>'test reply').should_not have_content("Edit")
	end	
end
	