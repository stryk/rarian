class HomeController < ApplicationController
  
  def index

  end

  def landing
    params[:sort_by] = "default"
    company_ids, company_type = Quote.get_cap(params)
    @buy_pitchs = get_records(Pitch.buy_pitch, params, {:type => 'longpitchs', :company_ids => company_ids, :company_type => company_type})
    @sell_pitchs = get_records(Pitch.sell_pitch, params, {:type => 'shortpitchs', :company_ids => company_ids, :company_type => company_type})
    @blips = get_records(Blip.all, params, {:type => 'blips', :company_ids => company_ids, :company_type => company_type})
    @filter = applied_filter(params)
    if !company_type.blank? && company_ids.blank?
      @catalyst = []
    elsif !company_ids.blank?
      @catalyst = Catalyst.where(['date >= ?', Date.today]).where(:company_id => company_ids).order("date asc").paginate(:page => params[:cat_page])
    else
      @catalyst = Catalyst.where(['date >= ?', Date.today]).order("date asc").paginate(:page => params[:cat_page])
    end
    
    respond_to do |format|
      format.js {
        @append = true
        if params[:lp_page].present?
          @pitchs = @buy_pitchs
          render 'buypitch.js.erb'
        elsif params[:sp_page].present?
          @pitchs = @sell_pitchs
          render 'sellpitch.js.erb'
        elsif params[:blp_page].present?
          render 'blips.js.erb'
        elsif params[:cat_page].present?
          render 'catalysts.js.erb'
        end
      }
      format.html
    end
  end

  def contact_us

  end

  def terms

  end

  def applied_filter(params)
    if params[:get] && params[:get] == 'small_cap'
      return "Small Cap - Market Cap less than $1B"
    elsif params[:get] && params[:get] == 'mid_cap'
      return "Mid Cap - Market Cap between $1B - $10B"
    elsif params[:get] && params[:get] == 'large_cap'
      return "Large Cap - Market Cap greater than $10B"
    elsif params[:sector]
      return "Sector - " + params[:sector]
    elsif params[:index] && params[:index] == 'snp500'
      return "Index - S&P 500"
    elsif params[:index] && params[:index] == 'snp400'
      return "Index - S&P 400"
    elsif params[:index] && params[:index] == 'snp600'
      return "Index - S&P 600"
    elsif params[:index] && params[:index] == 'nasdaq100'
      return "Index - Nasdaq 100"
    elsif params[:style] && params[:style] == 'value'
      return "Value Stocks"
    elsif params[:style] && params[:style] == 'growth'
      return "Growth Stocks"
    elsif params[:style] && params[:style] == 'momentum'
      return "Momentum Stocks - Stocks that have gained value in last 3mos, 1yr, and 3yrs."
    elsif params[:style] && params[:style] == 'dividend'
      return "Dividend Stocks - Stocks that historically yielded more than 4% in dividends."
    end
    return nil
  end



  def blips
    @append = true if params[:blp_page].present?
    @blips = get_records(Blip.all, params,{:type => 'blips'})
    respond_to do |format|
      format.js
    end
  end

  def sellpitch
    @append = true if params[:sp_page].present?
    @pitchs = get_records(Pitch.sell_pitch, params, {:type => 'shortpitchs'})
    respond_to do |format|
      format.js
    end
  end

  def buypitch
    @append = true if params[:lp_page].present?
    @pitchs = get_records(Pitch.buy_pitch, params, {:type => 'longpitchs'})
    respond_to do |format|
      format.js
    end
  end

  private



  #def buy_pitches(params = {})
  #  params[:buyrange] = 10 if params[:buyrange].blank?
  #
  #  Pitch.unscoped.where("created_at between '#{Date.today - params[:buyrange].to_i}' and '#{Date.today}'").buy_pitch
  #end
  #
  #def sell_pitches(params = {})
  #  params[:sellrange] = 10 if params[:sellrange].blank?
  #
  #  Pitch.unscoped.where("created_at between '#{Date.today - params[:sellrange].to_i}' and '#{Date.today}'").sell_pitch
  #
  #end

end
