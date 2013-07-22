class CompaniesController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :index

	def index
		@companies = Company.all.limit(50)
  end

  def show
    @company = Company.find(params[:id])
  end

	def import
		Company.import(params[:file], params[:exchange], params[:date])
		redirect_to companies_path, notice: "Company quotes imported."
	end


end
