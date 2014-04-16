require 'spec_helper'

describe User do
	before :each do
		@user = User.new({:username => 'test_user', :email => 'test@kth.se', :password => 'password'})
		@user.save
	end
	it "should be searchable by username" do
		User.find('test_user').should be_eql(@user)
	end
	it "should encrypt password" do
		@user.password_digest.should_not be_eql('password')
	end
	it "should authenticate  password" do
		@user.authenticate('password').should be_true		
		@user.authenticate('wrong').should be_false
	end
	it "should have a school" do
		pending
		# Adding school to user does not work
		#@user.school.create!(School.new({:name => 'KTH', :website => 'kth.se', :email_domain => '@kth.se'}))
		#puts User.find('test_user').school.name
	end
end
