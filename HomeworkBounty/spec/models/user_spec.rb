require 'spec_helper'

describe User do
	before :each do
		@school = School.create!({:name => 'KTH', :website => 'kth.se', :email_domain => '@kth.se'})
		@school.students.create!({:username => 'test_user', :email => 'test@kth.se', :password => 'password'})
		@user = @school.students[0]
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
		User.find('test_user').school.name.should be_eql('KTH')
	end
end
