class EmailAnswerActionWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform(answer_id, answerer_id)
		@answer = Answer.find_by_id(answer_id)
		
		@questioner = @answer.question.user
		if @questioner.email_answer_question
			@answerer = @answer.user
			UserMailer.send_answer_action(@answer, @answerer).deliver
		end
	end
end
