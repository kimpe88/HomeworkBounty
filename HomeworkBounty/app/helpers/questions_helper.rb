module QuestionsHelper
#Get the most answered/ most popular questions
	def get_popular_questions
		Question.all.sort_by {|q| q.answers.length}.reverse
	end
end
