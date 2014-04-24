require 'spec_helper'

describe "register/register_user.html.erb" do
	before :each do
		@country = Country.create!(:name => 'Sweden')
		#@school_args = {:name => 'kth', :website => 'kth.se', :email_domain => '@kth.se'}
		#@school = @country.schools.create!(@school_args)
		@user ={:username => 'testuser', :password => 'password123', :email => 'testing@kth.se'} 
		visit '/register'
	end

	it "should find register page at correct url" do
		page.should have_content('Register')
	end

	it "should register a user successfully" do
		fill_in('Username', :with => @user[:name]) 
		fill_in('Password', :with => @user[:password])
		fill_in('Email', :with => @user[:email])
		click_button('Create my account')
		page.should have_content('verify email')
	end

end
