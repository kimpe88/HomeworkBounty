
class Answer

  include Mongoid::Document
	include Mongoid::Timestamps
  field :body, type: String
	validates :body, :presence => true,
										:allow_blank =>false

	belongs_to :question, :class_name => 'Question', :inverse_of => 'answers'
	belongs_to :author_to_answer, :class_name => 'User', :inverse_of => 'answers_made'
	embeds_many :replies, :class_name => 'Reply', :inverse_of => 'reply_to_answer'

	def to_s
		"Question #{question.title}, Author #{author_to_answer.username}, Body #{body}"
	end

end

