
class Tag

  include Mongoid::Document
	# Tagname is id
	field :_id, type: String, default: ->{ name }
  field :name, type: String
	field :count, type: Integer
	validates :name, :presence => true,
										:allow_blank =>false
	validates :count, :presence => false,
										:allow_blank => true
	has_and_belongs_to_many :questions, :class_name => 'Tag', :inverse_of => 'tags'
	belongs_to :tag_category, :class_name => 'Category', :inverse_of => 'tags_under_category'

end

