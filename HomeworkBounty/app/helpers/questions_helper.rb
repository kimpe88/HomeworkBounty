module QuestionsHelper
#Get the most answered/ most popular questions
	def get_popular_questions
		questions_answers = {}
		Question.all.each do |question|
			questions_answers[question] = question.answers.length
		end
		Hash[questions_answers.sort_by{|k, v| v}.reverse[0..4]]
	end
end
