
class Tag

  include Mongoid::Document
	# Tagname is id
	field :_id, type: String, default: ->{ name }
  field :name, type: String
	validates :name, :presence => true,
										:allow_blank =>false
	has_and_belongs_to_many :questions, :class_name => 'Tag', :inverse_of => 'tags'

end

