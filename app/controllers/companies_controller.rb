class CompaniesController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :index

	def index
		@companies = Company.all.limit(50)
  end

  def show
    @blips = @company.blips
  end

	def import
		Company.import(params[:file], params[:exchange], params[:date])
		redirect_to companies_path, notice: "Company quotes imported."
  end

  def new_pitch

  end

  def create_pitch
    pitch = @company.pitches.create(params[:pitch].merge!(:user_id => current_user.id))
    if pitch.errors.blank?
      flash[:notice] = "Successfully added the reason"
      redirect_to company_path(@company)
    else
      flash[:error] = pitch.errors.full_messages.join(",")
      render :new_pitch
    end
  end

  def update
    @company.description = params[:company][:description]
    @company.save
  end


end
