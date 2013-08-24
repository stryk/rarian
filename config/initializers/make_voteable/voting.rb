module MakeVoteable
  class Voting < ActiveRecord::Base
    attr_accessible :voteable, :voter, :up_vote

    belongs_to :voteable, :polymorphic => true
    belongs_to :voter, :polymorphic => true
    after_create :update_most_active_ticker, :update_top_users, :update_competitor
    after_destroy :undo_most_active_ticker, :undo_top_users, :undo_update_competitor

    def update_most_active_ticker
      if voteable.try(:company)
        if self.up_vote?
          MostActiveTicker.up_vote(voteable.company)
        else
          MostActiveTicker.down_vote(voteable.company)
        end
      end
    end

    def undo_most_active_ticker
      value = self.up_vote? ? 1 : -1
      MostActiveTicker.undo_vote(voteable.company, value) if voteable.try(:company)
    end

    def update_top_users

      if voteable.try(:user) && voteable.try(:company)
        if self.up_vote?
          TopUser.up_vote(voteable.user, voteable.company)
        else
          TopUser.down_vote(voteable.user, voteable.company)
        end
      end
    end

    def undo_top_users
      value = self.up_vote? ? 1 : -1
      TopUser.undo_vote(voteable.user, voteable.company, value) if(voteable.try(:user) && voteable.try(:company))
    end

    def update_competitor
      if voteable.is_a?(Competitor)
        if self.up_vote?
          voteable.up_vote
        else
          voteable.down_vote
        end
      end
    end

    def undo_update_competitor
      if voteable.is_a?(Competitor)
        if self.up_vote?
          voteable.undo_vote(1)
        else
          voteable.undo_vote(-1)
        end
      end
    end
  end
end