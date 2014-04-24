require 'spec_helper'

describe Country do
  before :each do
		@country = Country.create!({:name => 'sweden'})
	end
	it "should be searchable by name" do
		Country.find(@country.name).should_not be_blank
	end
	it "should not have empty fields" do
		@country.name.should_not be_blank
	end
end
