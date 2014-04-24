require 'spec_helper'

describe "register/register_user.html.erb" do
	before :each do
		@country = Country.create!(:name => 'Sweden')
		@school_args = {:name => 'KTH', :website => 'kth.se', :email_domain => 'kth.se'}
		@school = @country.schools.create!(@school_args)
		@user ={:username => 'testuser', :password => 'password123',:password_confirmation => 'password123',  :email => 'testing@kth.se'} 
		visit '/register'
	end

	it "should find register page at correct url" do
		page.should have_content('Register')
	end

	it "should register a user successfully" do
		fill_in('Username', :with => @user[:username]) 
		fill_in('Password', :with => @user[:password])
		fill_in('Password confirmation', :with => @user[:password])
		fill_in('Email', :with => @user[:email])
		click_button('Create my account')
		page.should have_content('verify email')
	end

	it "it should fail to register with wrong email" do
		fill_in('Username', :with => @user[:username]) 
		fill_in('Password', :with => @user[:password])
		fill_in('Password confirmation', :with => @user[:password])
		fill_in('Email', :with => 'wrong@example.com')
		click_button('Create my account')
		page.should have_content('Email does not match')
	end

	it "it should fail to register with a taken email" do
		@school.students.create!(@user)
		fill_in('Username', :with => 'testuser2') 
		fill_in('Password', :with => @user[:password])
		fill_in('Password confirmation', :with => @user[:password])
		fill_in('Email', :with => @user[:email])
		click_button('Create my account')
		page.should have_content('Email is already taken')
	end

	it "it should fail to register with a taken username" do
		@school.students.create!(@user)
		fill_in('Username', :with => @user[:username]) 
		fill_in('Password', :with => @user[:password])
		fill_in('Password confirmation', :with => @user[:password])
		fill_in('Email', :with => 'unique@kth.se')
		click_button('Create my account')
		page.should have_content('Username is already taken')
	end

	it "it should fail with wrong password confirmation" do
		fill_in('Username', :with => @user[:username]) 
		fill_in('Password', :with => @user[:password])
		fill_in('Password confirmation', :with => 'wrongpassword')
		fill_in('Email', :with => @user[:email])
		click_button('Create my account')
		page.should have_content("Password confirmation doesn't match Password")
	end
end
