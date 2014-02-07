class EmailFollowActionWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform(follower_id, followee_id)
		follower = User.find_by_id(follower_id)
		followee = User.find_by_id(followee_id)
		if followee.email_follow_me
			UserMailer.send_follow_action(follower, followee).deliver
		end
	end
end
