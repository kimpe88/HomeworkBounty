
class Question

  include Mongoid::Document
	include Mongoid::Timestamps
  field :title, type: String
	field :body, type: String
	field :url, type: String
	validates :title, :body, :url, :presence => true,
										:allow_blank =>false
	before_validation :create_url
	
	#Automake the title into a nice looking url
	def create_url
		self.url = self.title.parameterize
	end
	
	#Belongs to a user
	belongs_to :question_author, :class_name => 'User', inverse_of: :questions
	has_many :answers_to_question, :class_name => 'Answer', inverse_of: :question_document
end

