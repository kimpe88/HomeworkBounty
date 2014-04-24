class UsersController < ApplicationController
	def create_instance_var
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
		user_params = params[:user].permit( :username, :password, :school, :email )
		school = School.find(user_params[:school])
		error = false
		begin
			@user = school.students.create(user_params)
			if @user.persisted?
				render 'verify_email'
			else
				render 'register_user'
			end
		rescue Moped::Errors::OperationFailure => e
			if [11000, 11001].include?(e.details['code'])
				# Duplicate key error show user that they need to choose another username
				@user.errors[:username] << " is not unique"
				render 'register_user'
			end
		end
	end
end
