
class Country
  include Mongoid::Document
	field :_id, type: String, default: ->{ name }
  field :name, type: String
	validates :name, :presence => true,
										:allow_blank =>false
	has_many :school, :class_name => 'School'
	
	
end

