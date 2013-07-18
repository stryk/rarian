class CompaniesController < ApplicationController
  skip_authorization_check

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
