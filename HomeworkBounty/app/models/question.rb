
class Question

  include Mongoid::Document
	include Mongoid::Timestamps
  field :title, type: String
	field :body, type: String
	field :url, type: String
	validates :title, :body, :presence => true,
										:allow_blank =>false
	#before_validation :create_url
	
	#Automake the title into a nice looking url
	def create_url
		self.url = self.title.parameterize
	end
	
	#Belongs to a user
	belongs_to :author, :class_name => 'User'
	embeds_many :answers, :class_name => 'Answer'
	def to_s
		"Question title #{title}, body #{body}"
	end
end

