require 'spec_helper'

describe User do
	before :each do
		@country = Country.create!({:name => 'sweden'})
		@school_args = {:name => 'kth', :website => 'kth.se', :email_domain => '@kth.se', :country_of_origin => 'sweden'}
		@school = School.create!(@school_args)
		@user_args = {:username => 'test_user', :email => 'test@kth.se', :password => 'password'}
		@school.students.create!(@user_args)
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
		User.find('test_user').school.name.should be_eql(@school_args[:name])
	end
	it "should not approve non school email" do
		expect { @school.students.create!({:username => 'test_user2', :email => 'test@gmail.se', :password => 'password'}) }.to raise_error
	end
	it "should not allow too short passwords" do
		expect {  @school.students.create!({:username => 'test_user2', :email => 'test@kth.se', :password => ''}) }.to raise_error
		expect {  @school.students.create!({:username => 'test_user2', :email => 'test@kth.se', :password => 'pass'}) }.to raise_error
	end
end
