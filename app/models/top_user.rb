class TopUser < ActiveRecord::Base
  attr_accessible :user_id, :no_of_up_votes, :no_of_down_votes, :no_of_votes

  belongs_to :user

  def self.up_vote(user)
    most_active_user = where(:user_id => user.id).last
    if most_active_user.blank?
      create(:no_of_up_votes => 1, :no_of_down_votes => 0, :no_of_votes => 1 ,
             :user_id => user.id)
    else
      most_active_user.update_attributes(:no_of_up_votes => most_active_user.no_of_up_votes+1,
                                         :no_of_votes => most_active_user.no_of_votes+1)
    end
  end


  def self.down_vote(user)
    most_active_user = where(:user_id => user.id).last
    if most_active_user.blank?
      create(:no_of_up_votes => 0, :no_of_down_votes => 1, :no_of_votes => -1 ,
             :user_id => user.id)
    else
      most_active_user.update_attributes(:no_of_down_votes => most_active_user.no_of_down_votes+1,
                                         :no_of_votes => most_active_user.no_of_votes-1)
    end
  end

  def self.undo_vote(user)
    most_active_user = where(:user_id => user.id).last
    most_active_user.update_attributes(:no_of_votes => most_active_user.no_of_votes-1)
  end

  def self.get_top_users(no_limit)
    order("no_of_votes DESC").limit(no_limit)
  end


end
