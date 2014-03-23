class TopUser < ActiveRecord::Base
  attr_accessible :company_id, :user_id, :no_of_up_votes, :no_of_down_votes, :no_of_votes
  validates :company_id, :user_id, :no_of_up_votes, :no_of_down_votes, :no_of_votes, presence: true
  belongs_to :user
  belongs_to :company

  def self.up_vote(user, company, object)
    most_active_user = where(:user_id => user.id, :company_id => company.id).last
    pt_multiple =  (Object.const_get object.voteable_type)::Point::UP rescue 1
    if most_active_user.blank?
      create(:no_of_up_votes => pt_multiple, :no_of_down_votes => 0, :no_of_votes => pt_multiple ,
             :user_id => user.id, :company_id => company.id)
    else
      most_active_user.update_attributes(:no_of_up_votes => most_active_user.no_of_up_votes+ pt_multiple,
                                         :no_of_votes => most_active_user.no_of_votes + pt_multiple)
    end
  end


  def self.down_vote(user, company, object)
    pt_multiple =  (Object.const_get object.voteable_type)::Point::UP rescue 1
    most_active_user = where(:user_id => user.id, :company_id => company.id).last
    if most_active_user.blank?
      create(:no_of_up_votes => 0, :no_of_down_votes => pt_multiple, :no_of_votes => -pt_multiple ,
             :user_id => user.id, :company_id => company.id)
    else
      most_active_user.update_attributes(:no_of_down_votes => most_active_user.no_of_down_votes+pt_multiple,
                                         :no_of_votes => most_active_user.no_of_votes + pt_multiple)
    end
  end

  def self.undo_vote(user, company, value, object)
    most_active_user = where(:user_id => user.id, :company_id => company.id).last
    pt_multiple =  (Object.const_get object.voteable_type)::Point::UP rescue 1
    if value > 0
      most_active_user.update_attributes(:no_of_up_votes => most_active_user.no_of_up_votes - pt_multiple, :no_of_votes => most_active_user.no_of_votes - pt_multiple)
    else
      most_active_user.update_attributes(:no_of_down_votes => most_active_user.no_of_down_votes - pt_multiple, :no_of_votes => most_active_user.no_of_votes + pt_multiple)
    end
  end

  def self.get_top_users(company, no_limit)
    where("company_id = ? AND no_of_votes > 0", company.id).order("no_of_votes DESC").limit(no_limit)
  end

  def self.get_user_companies(current_user, no_limit)
    where(:user_id => current_user.id).order("no_of_votes DESC").limit(no_limit)
  end


end
