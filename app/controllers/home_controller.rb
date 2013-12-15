class HomeController < ApplicationController
  
  def index

  end

  def landing
    @buy_pitchs = get_records(Pitch.buy_pitch, params)
    @sell_pitchs = get_records(Pitch.sell_pitch, params)
    @blips = get_records(Blip.all, params)
    @catalyst = Catalyst.order("date DESC").group_by(&:date)
  end

  def blips
    @blips = get_records(Blip.all, params)
    respond_to do |format|
      format.js
    end
  end

  def sellpitch
    @pitchs = get_records(Pitch.sell_pitch, params)
    respond_to do |format|
      format.js
    end
  end

  def buypitch
    @pitchs = get_records(Pitch.buy_pitch, params)
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
