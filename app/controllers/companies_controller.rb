class CompaniesController < ApplicationController

  
  before_filter :load_company
  skip_before_filter :load_company, :only => :index
  skip_before_filter :load_company, :only => :import
  skip_before_filter :load_company, :only => :search
  skip_authorize_resource :only => [:index, :search]
  load_and_authorize_resource

	def index		
  end

  def show
    params[:sort_by] = "default"
    @buy_pitches = get_records(@company.pitches.buy_pitch, params, {:type => 'longpitchs'})
    @sell_pitches = get_records(@company.pitches.sell_pitch, params, {:type => 'shortpitchs'})
    @blips = get_records(@company.blips, params,{:type => 'blips'})

    @catalyst = Catalyst.where(['company_id = ? and date >= ?', @company.id, Date.today]).order("date asc").paginate(:page => params[:cat_page])
    @competitors = Competitor.where(:company_id => @company.id).select("id, company_id, competitor_id, user_id, net_votes").order("net_votes DESC").paginate(:page => params[:comp_page])
    @risks = @company.risks.order("net_votes DESC").paginate(:page => params[:risk_page])
    respond_to do |format|
      format.js {
        if params[:lp_page].present?
          @pitchs = @buy_pitches
          render 'buypitch.js.erb'
        elsif params[:sp_page].present?
          @pitchs = @sell_pitches
          render 'sellpitch.js.erb'
        elsif params[:blp_page].present?
          render 'blips.js.erb'
        elsif params[:cat_page].present?
          render 'catalysts.js.erb'
        elsif params[:comp_page].present?
          render 'competitors.js.erb'
        elsif params[:risk_page].present?
          render 'risks.js.erb'
        end
      }
      format.html
    end
  end

  def follow
    current_user.follow(@company)
  end

  def unfollow
    current_user.stop_following(@company)
    render 'follow.js.erb'
  end

	def import
		Company.import(params[:file], params[:exchange], params[:date])
		redirect_to companies_path, notice: "Company quotes imported."
  end

  def new_pitch

  end

  def search
    company = Company.arel_table
    companies = Company.where(company[:name].matches("%#{params[:name_startsWith]}%").or(company[:ticker].matches("%#{params[:name_startsWith]}%")))
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

  def blips
    @append = true if params[:blp_page].present?
    @blips = get_records(@company.blips, params,{:type => 'blips'})
    respond_to do |format|
      format.js
    end
  end

  def sellpitch
    @append = true if params[:sp_page].present?
    @pitchs = get_records(@company.pitches.sell_pitch, params, {:type => 'shortpitchs'})
    respond_to do |format|
      format.js
    end
  end

  def buypitch
    @append = true if params[:lp_page].present?
    @pitchs = get_records(@company.pitches.buy_pitch, params, {:type => 'longpitchs'})
    respond_to do |format|
      format.js
    end
  end

  private

  def load_company
    if params[:id] == nil
      @company = nil
    else
      @company= Company.friendly.find(params[:id].to_s.downcase)
    end
  end


end
