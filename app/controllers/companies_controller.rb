class CompaniesController < ApplicationController
	def index
		@companies = Company.all.limit(50)
	end

	def import
		Company.import(params[:file], params[:exchange])
		redirect_to companies_path, notice: "Company quotes imported."
	end


end
