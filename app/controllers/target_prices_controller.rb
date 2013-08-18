class TargetPricesController < ApplicationController
  load_and_authorize_resource :company

  def create
    @target_price = TargetPrice.where(:year => params[:target_price][:year],
                                      :company_id => @company.id,
                                      :user_id => current_user.id).first_or_initialize(:target_price => params[:target_price][:target_price])
    @target_price.new_record? ? @target_price.save :
      @target_price.update_attributes(:target_price => params[:target_price][:target_price])

  end


  def destroy
    TargetPrice.where(:id => params[:id]).last.destroy
    respond_to do |format|
      format.js {render 'create'}

    end
  end


end
