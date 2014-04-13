class User
  include Mongoid::Document
	# Use username as id
	field :_id, type: String, default: ->{ username }
  field :username, type: String
  field :email, type: String
  field :password, type: String
end
