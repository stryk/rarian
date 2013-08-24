class MostActiveTicker < ActiveRecord::Base
  attr_accessible :company_id, :no_of_up_votes, :no_of_down_votes, :no_of_votes, :active_date

  validates :no_of_up_votes, :no_of_down_votes, :company_id, :no_of_votes, :active_date, presence: true

  belongs_to :company

  def self.up_vote(company)
    most_active_on_date = where(:active_date => Date.today, :company_id => company. id).last
    if most_active_on_date.blank?
      create(:no_of_up_votes => 1, :no_of_down_votes => 0, :no_of_votes => 1 ,
             :active_date => Date.today, :company_id => company.id)
    else
      most_active_on_date.update_attributes(:no_of_up_votes => most_active_on_date.no_of_up_votes+1,
                                            :no_of_votes => most_active_on_date.no_of_votes+1)
    end
  end


  def self.down_vote(company)
    most_active_on_date = where(:active_date => Date.today, :company_id => company. id).last
    if most_active_on_date.blank?
      create(:no_of_up_votes => 0, :no_of_down_votes => 1, :no_of_votes => -1 ,
             :active_date => Date.today, :company_id => company.id)
    else
      most_active_on_date.update_attributes(:no_of_down_votes => most_active_on_date.no_of_down_votes+1,
                                            :no_of_votes => most_active_on_date.no_of_votes-1)
    end
  end

  def self.undo_vote(company, value)
    most_active_on_date = where(:active_date => Date.today, :company_id => company. id).last
    most_active_on_date.update_attributes(:no_of_votes => most_active_on_date.no_of_votes-value)
  end

  def self.get_active_companies
     where("active_date between '#{Date.today - 1.day}' and '#{Date.today}'").order("no_of_votes DESC")
     # TODO we should do grouping for uniq company
     #group('company_id')
  end
end
