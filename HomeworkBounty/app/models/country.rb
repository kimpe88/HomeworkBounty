
class Country
  include Mongoid::Document
	field :_id, type: String, default: ->{ name }
  field :name, type: String
	validates :name, :presence => true,
										:allow_blank =>false
	validates_uniqueness_of :name
	has_many :schools, :class_name => 'School'
	
	
end

