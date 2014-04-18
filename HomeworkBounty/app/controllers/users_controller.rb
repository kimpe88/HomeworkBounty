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
		begin
			@user = school.students.create(user_params)
		rescue => e
			error = True
		end
    if @user and not error
      render nothing: true
    else
      render nothing: true
    end
	end
end
