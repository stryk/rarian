class RisksController < ApplicationController
  before_filter :find_company
  load_and_authorize_resource

  def create
    @risk = @company.risks.create(:user_id => current_user.id,:company_id => @company.id ,
                                  :risk =>  params[:risk][:risk])
    respond_to do |format|
      if @risk.errors.blank?
        format.js {}
      else
      end
    end
  end

  def create_old
    @risk = Risk.where(:company_id => @company.id, :user_id => current_user.id).
      first_or_initialize(:risk => params[:risk][:risk])
    @risk.new_record? ? @risk.save :
      @risk.update_attributes(:risk => params[:risk][:risk])
  end

  def edit
    @risk = Risk.find(params[:id])

    respond_to do |format|
      if @risk.update_attributes(:risk => params[:risk][:risk])
        format.js {}
      end

    end
  end

  def destroy
    Risk.where(:id => params[:id]).last.destroy
    respond_to do |format|
      format.js {render 'create'}
    end
  end

  private

  def find_company
    @company = Company.friendly.find((params[:company_id]).downcase)
  end
  
end
