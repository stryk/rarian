class RisksController < ApplicationController
  load_and_authorize_resource :company

  def create
    @risk = Risk.where(:company_id => @company.id, :user_id => current_user.id).
      first_or_initialize(:risk => params[:risk][:risk])
    @risk.new_record? ? @risk.save :
      @risk.update_attributes(:risk => params[:risk][:risk])
  end

  def destroy
    Risk.where(:id => params[:id]).last.destroy
    respond_to do |format|
      format.js {render 'create'}
    end
  end
end
