class PitchesController < ApplicationController
  load_and_authorize_resource

  before_filter :load_company

  def new

  end

  def create
    pitch = @company.pitches.create(params[:pitch].merge!(:user_id => current_user.id))
    if pitch.errors.blank?
      flash[:notice] = "Successfully added the reason"
      redirect_to company_path(@company)
    else
      flash[:error] = pitch.errors.full_messages.join(",")
      render :new_pitch
    end
  end

  def edit

  end

  def show
    authorize! :show, @pitch
  end

  def load_company
    @company= Company.find(params[:company_id])
  end
end
