class CatalystsController < ApplicationController
  prepend_before_filter :find_company
  load_and_authorize_resource

  def index
    @catalyst = Catalyst.where(['company_id = ? and date >= ?', @company.id, Date.today]).order("date asc").paginate(:page => params[:cat_page])
    respond_to do |format|
      format.js
    end
  end

  def create
    @catalyst = Catalyst.find(params[:catalyst_id]) rescue Catalyst.new
    @catalyst = @catalyst.update_attributes(:date => params[:catalyst][:date],
                               :company_id => @company.id,
                               :user_id => current_user.id,
                               :content => params[:catalyst][:content])
    #@catalyst.new_record? ? @catalyst.save :
    #  @catalyst.update_attributes(:content => params[:catalyst][:content])
    @catalyst = Catalyst.where(['company_id = ? and date >= ?', @company.id, Date.today]).order("date asc").paginate(:page => params[:cat_page])
    respond_to do |format|
      format.js { render 'create' }
    end
  end

  def destroy
    Catalyst.where(:id => params[:id]).last.destroy
    @deleted_catalyst_id = params[:id]
    respond_to do |format|
      format.js
    end
  end

  private

  def find_company
    @company = Company.friendly.find((params[:company_id]).downcase)

  end
end
