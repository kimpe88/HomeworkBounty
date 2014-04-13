require 'spec_helper'

describe User do
	before :each do
		@user = User.new({:username => 'test_user', :email => 'test@kth.se', :password => 'password'})
		@user.save
	end
	it "should be searchable by username" do
		User.find('test_user').should be_eql(@user)
	end
end
