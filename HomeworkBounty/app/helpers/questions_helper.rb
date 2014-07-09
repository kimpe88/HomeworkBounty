module QuestionsHelper
#Get the most answered/ most popular questions
	def get_popular_questions
		Question.limit(10).sort_by {|q| q.answers.length}.reverse
	end

	def get_latest_questions
		Question.limit(10).order('created_at desc')
	end
	def get_tags_by_category
		tags = {}
		Category.each do |category|
			tags[category.name] = category.tags_under_category.pluck(:name)
		end
	end
	def can_reply_answer?(answer)
			if(current_user.nil?)
				return false
			elsif(answer.replies.length == 0) && (answer.author_to_answer.username != current_user.username)		
				return true
			else
				return false
			end
	end
	def can_reply?(answer,reply)
			if(current_user.nil?)
				return false
			elsif (reply.count == answer.replies.length) && (reply.author != current_user.username)
				return true
			else
				return false
			end
	end
	def can_accept(question,answer)
		if(current_user == question.author_to_question) && (answer.accepted?)
			return "unaccept"
		elsif(current_user == question.author_to_question) && (!answer.accepted?) && (!question.answered?)
			return "accept"
		else
			"hide"
		end
	end
	def can_answer?(question)
		if(current_user == question.author_to_question)	
			return false
		end
		question.answers.each do |answer|
			if(answer.author_to_answer == current_user)
				return false
			end
		end	
		return true
	end
end
