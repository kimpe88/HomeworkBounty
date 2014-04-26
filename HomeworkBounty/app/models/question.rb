
class Question

  include Mongoid::Document
	include Mongoid::Timestamps
  field :title, type: String
	validates :title, :presence => true,
										:allow_blank =>false
  field :body, type: String
	validates :body, :presence => true,
										:allow_blank =>false
  field :url, type: String
	validates :url, :presence => false,
										:allow_blank =>true
										
	validate:create_url
	
	#Automake the title into a nice looking url
	def create_url
		self.url = self.title.parameterize
	end
	
	#Belongs to a user
	belongs_to :user, :class_name => 'User'
	has_many :answers, :class_name => 'Answer', inverse_of: :question
end

