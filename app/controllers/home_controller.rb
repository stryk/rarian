class HomeController < ApplicationController
  
  def index

  end

  def landing
    params[:sort_by] = "default"
    @buy_pitchs = get_records(Pitch.buy_pitch, params, {:type => 'longpitchs'})
    @sell_pitchs = get_records(Pitch.sell_pitch, params, {:type => 'shortpitchs'})
    @blips = get_records(Blip.all, params, {:type => 'blips'})
    @catalyst = Catalyst.where(['date >= ?', Date.today]).order("date asc").paginate(:page => params[:cat_page])
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
