class User
  include Mongoid::Document
	include ActiveModel::SecurePassword
	# Use username as id
	field :_id, type: String, default: ->{ username }
  field :username, type: String
  field :email, type: String
  # Uses secure password from active model
  # http://apidock.com/rails/ActiveModel/SecurePassword/ClassMethods/has_secure_password
  field :password_digest, type: String
  has_secure_password

end
