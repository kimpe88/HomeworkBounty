module QuestionsHelper
#Get the most answered/ most popular questions
	def get_popular_questions
		Question.limit(10).sort_by {|q| q.answers.length}.reverse
	end

	def get_latest_questions
		Question.limit(10).order('created_at desc')
	end
end
