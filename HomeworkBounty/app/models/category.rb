class Category

  include Mongoid::Document
	# Categoryname is id
	field :_id, type: String, default: ->{ name }
  field :name, type: String
	validates :name, :presence => true,
										:allow_blank =>false
	has_many :questions_under_category, :class_name => 'Question', :inverse_of => 'question_category'
	has_many :tags_under_category, :class_name => 'Tag', :inverse_of => 'tag_category'

end