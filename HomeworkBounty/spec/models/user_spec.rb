require 'spec_helper'

describe User do
	it "should be searchable by username" do
		User.find(@user.username).should be_eql(@user)
	end
	it "should encrypt password" do
		@user.encrypted_password.should_not be_eql('password')
	end
	it "should have a school" do
		User.find(@user.username).school.name.should be_eql(@school.name)
	end
	it "should not approve non school email" do
		expect { @school.students.create!({:username => 'test_user2', :email => 'test@gmail.se', :password => 'password'}) }.to raise_error
	end
	it "should not allow too short passwords" do
		expect {  @school.students.create!({:username => 'test_user2', :email => 'test@kth.se', :password => ''}) }.to raise_error
		expect {  @school.students.create!({:username => 'test_user2', :email => 'test@kth.se', :password => 'pass'}) }.to raise_error
	end
end
