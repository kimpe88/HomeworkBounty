require 'spec_helper'

describe School do
	before :each do
		@country = Country.create!({:name => 'sweden'})
		@school = School.create!({:name => 'KTH', :website => 'kth.se', :email_domain => '@kth.se'})
	end
	it "should be searchable by name" do
		School.find(@school.name).should_not be_blank
	end
	it "it should have a student" do
		@school.students.create!({:username => 'test_user', :email =>'test_user@kth.se', :password => 'passsword'})
		School.find(@school.name).students[0].username.should be_eql('test_user')
	end
	it "should not allow empty fields" do
		expect { School.create!({:name => 'KTH1', :website => 'kth.se' })}.to raise_error	
		expect { School.create!({:name => 'KTH2', :website => ' ', :email_domain => '@kth.se'})}.to raise_error	
		expect { School.create!({:name => 'KTH3', :website => 'kth.se', :email_domain => ''})}.to raise_error
	end

end
