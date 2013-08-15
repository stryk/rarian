module MakeVoteable
  module Voter
    extend ActiveSupport::Concern
    def up_voted?(voteable)
      check_voteable(voteable)
      voting = fetch_voting(voteable)
      return true if voting && voting.has_attribute?(:up_vote) && voting.up_vote
      false
    end

    # Returns true if the voter down voted the +voteable+.
    def down_voted?(voteable)
      check_voteable(voteable)
      voting = fetch_voting(voteable)
      return true if voting && voting.has_attribute?(:up_vote) && !voting.up_vote
      false
    end


    def up_vote(voteable)
      check_voteable(voteable)

      voting = fetch_voting(voteable)

      if voting
        if voting.up_vote
          raise MakeVoteable::Exceptions::AlreadyVotedError.new(true)
        else
          voting.up_vote = true
          voteable.down_votes -= 1
          self.down_votes -= 1 if self.has_attribute?(:down_votes)
        end
      else
        voting = Voting.create(:voteable => voteable, :voter => self, :up_vote => true)
      end

      voteable.up_votes += 1
      self.up_votes += 1 if self.has_attribute?(:up_votes)

      MakeVoteable::Voting.transaction do
        self.save
        voteable.save
        voting.save
      end
    end
  end
end

