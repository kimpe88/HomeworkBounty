class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :create_instance_var
	before_action :configure_permitted_parameters, if: :devise_controller?

	def create_instance_var
		@countries =  []
		Country.all.each do |country|
			@countries << country.name
		end
		@schools = []
		School.all.each do |school|
			@schools << school.name
		end
	end

  # def new
  #   super
  # end
 
	def create
    build_resource(sign_up_params)
		begin
			school = School.find(params[:school])
			resource.role = 'user' # Override default guest role
			school.students << resource
			resource_saved = resource.save
			yield resource if block_given?
			if resource_saved
				if resource.active_for_authentication?
					set_flash_message :notice, :signed_up if is_flashing_format?
					sign_up(resource_name, resource)
					respond_with resource, location: after_sign_up_path_for(resource)
				else
					set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
					expire_data_after_sign_in!
					respond_with resource, location: after_inactive_sign_up_path_for(resource)
				end
			else
				clean_up_passwords resource
				respond_with resource
			end
		rescue Mongoid::Errors::DocumentNotFound => e
			resource.errors[:school] << " is invalid"
			respond_with resource
		end
  end

	protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :email
  end
end
