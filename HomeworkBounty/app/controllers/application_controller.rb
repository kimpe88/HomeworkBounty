class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	include ApplicationHelper
  protect_from_forgery with: :exception
	before_filter :store_location
	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = 'Access Denied'
		redirect_to root_url
	end


	private
	# Store location so we can redirect to previous url after logging in
	def store_location
		# store last url - this is needed for post-login redirect to whatever the user last visited.
		if (request.fullpath != "/users/sign_in" &&
				request.fullpath != "/users/sign_up" &&
				request.fullpath != "/users/password" &&
				request.fullpath != "/users/sign_out" &&
				request.fullpath !~ /\/users\/confirmation/i &&
				!request.xhr?) # don't store ajax calls
			session[:previous_url] = request.fullpath
		end
	end

	def after_sign_in_path_for(resource)
		previous_url
	end
	helper_method :previous_url
	def previous_url
		session[:previous_url] || root_path
	end
end
