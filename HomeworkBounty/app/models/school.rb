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
	field :country_of_origin, type: String
	validates :country_of_origin, :presence => true,
													 :allow_blank =>false
	validate :country_of_origin_exists
	
	has_many :students, :class_name => 'User'
	belongs_to :country, :class_name => 'Country'
	
	#Validate that coutry is an actual country in the model
	
	def country_of_origin_exists
		return false if Country.find(self.country_of_origin).nil?
	end
end
