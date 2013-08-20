class CatalystsController < ApplicationController
  load_and_authorize_resource :company

  def create
    @catalyst = Catalyst.where(:date => params[:catalyst][:date],
                                      :company_id => @company.id,
                                      :user_id => current_user.id).first_or_initialize(:content => params[:catalyst][:content])
    @catalyst.new_record? ? @catalyst.save :
      @catalyst.update_attributes(:content => params[:catalyst][:content])

  end

  def destroy
    Catalyst.where(:id => params[:id]).last.destroy
    respond_to do |format|
      format.js {render 'create'}
    end
  end
end
