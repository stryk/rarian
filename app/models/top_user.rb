class TopUser < ActiveRecord::Base
  attr_accessible :company_id, :user_id, :no_of_up_votes, :no_of_down_votes, :no_of_votes
  validates :company_id, :user_id, :no_of_up_votes, :no_of_down_votes, :no_of_votes, presence: true
  belongs_to :user
  belongs_to :company

  def self.up_vote(user, company)
    most_active_user = where(:user_id => user.id, :company_id => company.id).last
    if most_active_user.blank?
      create(:no_of_up_votes => 1, :no_of_down_votes => 0, :no_of_votes => 1 ,
             :user_id => user.id, :company_id => company.id)
    else
      most_active_user.update_attributes(:no_of_up_votes => most_active_user.no_of_up_votes+1,
                                         :no_of_votes => most_active_user.no_of_votes+1)
    end
  end


  def self.down_vote(user, company)
    most_active_user = where(:user_id => user.id, :company_id => company.id).last
    if most_active_user.blank?
      create(:no_of_up_votes => 0, :no_of_down_votes => 1, :no_of_votes => -1 ,
             :user_id => user.id, :company_id => company.id)
    else
      most_active_user.update_attributes(:no_of_down_votes => most_active_user.no_of_down_votes+1,
                                         :no_of_votes => most_active_user.no_of_votes-1)
    end
  end

  def self.undo_vote(user, company, value)
    most_active_user = where(:user_id => user.id, :company_id => company.id).last
    most_active_user.update_attributes(:no_of_votes => most_active_user.no_of_votes-value)
  end

  def self.get_top_users(company, no_limit)
    where(:company_id => company.id).order("no_of_votes DESC").limit(no_limit)
  end

  def self.get_user_companies(current_user, no_limit)
    where(:user_id => current_user.id).order("no_of_votes DESC").limit(no_limit)
  end


end
