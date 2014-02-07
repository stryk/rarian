class EmailCommentActionWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform(comment_id)
		@comment = Comment.find_by_id(comment_id)
		@commented_article = eval(@comment.commentable_type).find_by_id(@comment.commentable_id)
		if @commented_article.user.email_comment
			UserMailer.send_comment_action(@comment, @commented_article).deliver
		end
	end
end
