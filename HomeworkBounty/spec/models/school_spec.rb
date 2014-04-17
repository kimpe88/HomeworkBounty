require 'spec_helper'

describe School do
	before :each do
		@school = School.create!({:name => 'KTH', :website => 'kth.se', :email_domain => '@kth.se'})
	end
	it "should be searchable by name" do
		School.find(@school.name).should_not be_blank
	end
	it "it should have a student" do
		@school.students.create!({:username => 'test_user', :email =>'test_user@kth.se', :password => 'hejsan'})
		School.find(@school.name).students[0].username.should be_eql('test_user')
	end

end
