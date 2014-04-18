class UsersController < ApplicationController
	def new 
		@schools = [] 
		School.all.each do |school| 	
			@schools << school.name
		end
		@user = User.new
		render 'register_user'
	end
	def create
		user_params = params[:user].permit( :username, :password, :school, :email )
		school = School.find(user_params[:school])
		error = false
		begin
			user = school.students.create(user_params)
			if user.persisted?
				@user = user
				render :json => @user
			else
				redirect_to '/register'
			end
		rescue Moped::Errors::OperationFailure 
			if [11000, 11001].include?(e.details['code'])
				# Duplicate key error show user that they need to choose another username
			end
		end
	end
end
