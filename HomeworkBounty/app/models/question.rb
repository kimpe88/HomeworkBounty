
class Question

  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Slug
  field :title, type: String
	field :body, type: String
	field :url, type: String
	validates :title, :body, :presence => true,
										:allow_blank =>false
	#validates_uniqueness_of :title
	slug :title, history: true

	#Belongs to a user
	belongs_to :author_to_question, :class_name => 'User', :inverse_of => 'questions_made'
	has_many :answers, :class_name => 'Answer', :inverse_of => 'question'

	def to_s
		"Question title #{title}, body #{body}"
	end
end

