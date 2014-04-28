
class Answer

  include Mongoid::Document
	include Mongoid::Timestamps
  field :body, type: String
	field :author, type: String
	validates :body,:author, :presence => true,
										:allow_blank =>false
	
	embedded_in :question, :class_name => 'Question'
end

