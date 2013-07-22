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
  end
end

