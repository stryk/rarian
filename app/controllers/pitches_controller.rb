class PitchesController < ApplicationController
  load_and_authorize_resource

  before_filter :load_company

  def new

  end

  def show
    @pitch = Pitch.where(:id => params[:id])

    respond_to do |format|
      format.js {}
    end
  end

  def create
    @pitch = @company.pitches.create(params[:pitch].merge!(:user_id => current_user.id))
    if @pitch.errors.blank?
      #flash[:notice] = "Successfully added the reason"
      @msg = "Pitch added."
      #redirect_to company_path(@company)
      respond_to do |format|
        format.js
      end
    else
      #flash[:error] = pitch.errors.full_messages.join(",")
      #render :new, :action_type => params[:action]
    end
  end

  def update
    @pitch.update_attributes(params[:pitch])
    if @pitch.errors.blank?
      #flash[:notice] = "Successfully added the reason"
      @msg = "Update complete."
      #redirect_to company_path(@company)
      respond_to do |format|
        format.js
      end
    else
      #flash[:error] = pitch.errors.full_messages.join(",")
      #render :new, :action_type => params[:action]
    end

  end

  def destroy
    deleted_pitch = Pitch.where(:id => params[:id]).last
    @deleted_pitch_id = deleted_pitch.id
    deleted_pitch.destroy
    respond_to do |format|
      format.js {render 'destroy'}
    end
  end

  private

  def load_company
    @company= Company.friendly.find((params[:company_id]).downcase)
  end

  
  
end
