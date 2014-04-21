class User
  include Mongoid::Document
	include ActiveModel::SecurePassword
	# Use username as id
	field :_id, type: String, default: ->{ username }
  field :username, type: String
  field :email, type: String
  validate :student_email
  # Uses secure password from active model
  # http://apidock.com/rails/ActiveModel/SecurePassword/ClassMethods/has_secure_password
  field :password_digest, type: String
	validates :password, :length => {:minimum => 6, :message => " minmum length is 6 characters"}
  has_secure_password
  belongs_to :school, :class_name => 'School'

  def student_email
		if not self.email =~ /#{school.email_domain}$/i
  		errors[:Email] << "does not match school email domain"
  	end
	end

	def to_s
		"Username #{username}, email #{email}, password #{password}"
	end
end
