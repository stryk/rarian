module MakeVoteable
  class Voting < ActiveRecord::Base
    attr_accessible :voteable, :voter, :up_vote

    belongs_to :voteable, :polymorphic => true
    belongs_to :voter, :polymorphic => true
    after_create :update_most_active_ticker
    after_destroy :undo_most_active_ticker

    def update_most_active_ticker
      if self.up_vote?
        MostActiveTicker.up_vote(voteable.company)
      else
        MostActiveTicker.down_vote(voteable.company)
      end
    end

    def undo_most_active_ticker
      MostActiveTicker.undo_vote(voteable.company)
    end
  end
end