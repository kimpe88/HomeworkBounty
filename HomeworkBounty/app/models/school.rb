class School
  include Mongoid::Document
	field :_id, type: String, default: ->{ name }
  field :name, type: String
	 field :website, type: String
	 field :email_domain, type: String
  validates :name,:website, :email_domain, :presence => true,
									 :allow_blank =>false
	validates_uniqueness_of :name, :website, :email_domain
	has_many :students, :class_name => 'User'
	belongs_to :country, :class_name => 'Country'
end
