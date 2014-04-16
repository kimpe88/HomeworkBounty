class School
  include Mongoid::Document
	field :_id, type: String, default: ->{ name }
  field :name, type: String
  field :website, type: String
  field :email_domain, type: String
	has_many :students, :class_name => 'User'
end
