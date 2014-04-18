class School
  include Mongoid::Document
	field :_id, type: String, default: ->{ name }
  field :name, type: String
  validates :name, :presence => true,
									 :allow_blank =>false
  field :website, type: String
	validates :website, :presence => true,
											:allow_blank =>false
  field :email_domain, type: String
	validates :email_domain, :presence => true,
													 :allow_blank =>false
	has_many :students, :class_name => 'User'
end
