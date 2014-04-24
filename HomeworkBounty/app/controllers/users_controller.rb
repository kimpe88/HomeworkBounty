class UsersController < ApplicationController
	def create_instance_var
		@countries =  []
		Country.all.each do |country|
			@countries << country.name
		end
		@schools = [] 
		School.all.each do |school| 	
			@schools << school.name
		end
		@user = User.new
	end
	def new 
		self.create_instance_var
		render 'register_user'
	end
	def create
		self.create_instance_var
		user_params = params[:user].permit( :username, :password, :password_confirmation, :school, :email )
		begin
			school = School.find(user_params[:school])
			@user = school.students.create(user_params)
			if @user.persisted?
				render 'verify_email'
			else
				render 'register_user'
			end
		rescue Mongoid::Errors::DocumentNotFound => e
			@user.errors[:school] << " is invalid"
			render 'register_user'
		end
	end
end
