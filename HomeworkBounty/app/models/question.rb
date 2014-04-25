
class Question

  include Mongoid::Document
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
end

