class UsersController < ApplicationController
	def create_sessions_var
		@schools = [] 
		School.all.each do |school| 	
			@schools << school.name
		end
		@user = User.new
	end
	def new 
		self.create_session_var
		puts "USER STATUS " + @user 
		render 'register_user'
	end
	def create
		if @user.nil?
			self.create_sessions_var
		end
		user_params = params[:user].permit( :username, :password, :school, :email )
		school = School.find(user_params[:school])
		error = false
		begin
			@user = school.students.create(user_params)
			if @user.persisted?
				render :json => @user
			else
				render 'register_user'
			end
		rescue Moped::Errors::OperationFailure 
			if [11000, 11001].include?(e.details['code'])
				# Duplicate key error show user that they need to choose another username
			end
		end
	end
end
