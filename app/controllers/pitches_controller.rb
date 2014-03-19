class PitchesController < ApplicationController
  load_and_authorize_resource

  before_filter :load_company

  def new

  end

  def show
    @pitch = Pitch.friendly.find(params[:id])
    if @pitch.present?
      @blips = get_records(@pitch.company.blips, params,{:type => 'blips'})
      @catalyst = Catalyst.where(['company_id = ? and date >= ?', @pitch.company.id, Date.today]).order("date asc").paginate(:page => params[:cat_page])
    end
    respond_to do |format|
      format.html
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
    @pitch.offloaded = false
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
    deleted_pitch = Pitch.friendly.find(params[:id])
    @deleted_pitch_id = deleted_pitch.id
    deleted_pitch.destroy
    respond_to do |format|
      format.js {render 'destroy'}
    end
  end

  private

  def load_company
    if params[:company_id].present?
      @company= Company.friendly.find((params[:company_id]).downcase)
    end
  end

  
  
end
