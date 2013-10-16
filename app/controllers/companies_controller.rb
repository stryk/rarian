class CompaniesController < ApplicationController

  load_and_authorize_resource
  skip_authorize_resource :only => :index

	def index
		@companies = Company.all.limit(50)

  end

  def show
    @blips = @company.blips
    @catalyst = Catalyst.where(:company_id => @company.id).order("date ASC").group_by(&:date)
  end

	def import
		Company.import(params[:file], params[:exchange], params[:date])
		redirect_to companies_path, notice: "Company quotes imported."
  end

  def new_pitch

  end

  def search
    company = Company.arel_table
    companies = Company.where(company[:name].matches("%#{params[:q]}%").or(company[:ticker].matches("%#{params[:q]}%")))
    options = []
    show_options = []
    companies.each do |company|
      options << {:id => company.id, :name => company.name + "-" + company.ticker}
      show_options << company.name + "-" + company.ticker
    end
    render :json => {:options => options, :show_options => show_options}
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
