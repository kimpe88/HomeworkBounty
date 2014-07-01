
class Reply
  include Mongoid::Document
  field :body, type: String
	validates :body, :presence => true,
										:allow_blank =>false
  field :count, type: Integer
	field :author, type: String
	embedded_in :reply_to_answer, :class_name => 'Answer', :inverse_of => 'replies'
end

