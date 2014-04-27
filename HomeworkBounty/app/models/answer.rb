
class Answer

  include Mongoid::Document
	include Mongoid::Timestamps
  field :body, type: String
	validates :body, :presence => true,
										:allow_blank =>false
	
	belongs_to :user, class_name: "User"
	belongs_to :question, class_name: "Question"
end

