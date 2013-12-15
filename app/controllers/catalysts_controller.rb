class CatalystsController < ApplicationController
  prepend_before_filter :find_company
  load_and_authorize_resource

  def create
    @catalyst = Catalyst.find(params[:catalyst_id]) rescue Catalyst.new
    @catalyst = @catalyst.update_attributes(:date => params[:catalyst][:date],
                               :company_id => @company.id,
                               :user_id => current_user.id,
                               :content => params[:catalyst][:content])
    #@catalyst.new_record? ? @catalyst.save :
    #  @catalyst.update_attributes(:content => params[:catalyst][:content])
    @catalyst = Catalyst.where(:company_id => @company.id).order("date ASC").group_by(&:date)
  end

  def destroy
    Catalyst.where(:id => params[:id]).last.destroy
    @catalyst = Catalyst.where(:company_id => @company.id).order("date ASC").group_by(&:date)
    respond_to do |format|
      format.js { render 'create' }
    end
  end

  private

  def find_company
    @company = Company.friendly.find((params[:company_id]).downcase)

  end
end
