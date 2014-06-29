
class Question

  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Slug
	include Mongoid::TagsArentHard
  field :title, type: String
	field :body, type: String
	field :url, type: String
	validates :title, :body, :presence => true,
										:allow_blank =>false
	#validates_uniqueness_of :title
	slug :title, history: true
	taggable_with :taglist
	
	
	#Belongs to a user
	belongs_to :author_to_question, :class_name => 'User', :inverse_of => 'questions_made'
	belongs_to :question_category, :class_name => 'Category', :inverse_of => 'questions_under_category'
	has_and_belongs_to_many :tags, :class_name => 'Tag', :inverse_of => 'questions'
	has_many :answers, :class_name => 'Answer', :inverse_of => 'question'


	def to_s
		"Question title #{title}, body #{body}"
	end
	
	
end

