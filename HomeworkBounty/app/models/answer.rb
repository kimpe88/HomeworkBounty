
class Answer

  include Mongoid::Document
	include Mongoid::Timestamps
  field :body, type: String
	validates :body, :presence => true,
										:allow_blank =>false
	
	belongs_to :user, class_name: "User", inverse_of: :answers
	belongs_to :question, class_name: "Question", inverse_of: :answers
end

