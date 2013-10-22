class HomeController < ApplicationController

  def index

  end

  def landing
    @blips = Blip.order("created_at asc")
    @catalyst = Catalyst.order("date DESC").group_by(&:date)
  end

  def blips
    params[:sort_by] = 'asc' if params[:sort_by].blank?
    params[:range] = 10 if params[:range].blank?
    @blips = Blip.unscoped.order("created_at #{params[:sort_by]}").where("created_at between '#{Date.today - params[:range].to_i}' and '#{Date.today}'")
    respond_to do |format|
      format.js
    end
  end

  def sellpitch
    params[:sellrange] = 10 if params[:sellrange].blank?

    @pitchs = Pitch.unscoped.where("created_at between '#{Date.today - params[:sellrange].to_i}' and '#{Date.today}'").sell_pitch
    respond_to do |format|
      format.js
    end
  end

  def buypitch
    params[:buyrange] = 10 if params[:buyrange].blank?

    @pitchs = Pitch.unscoped.where("created_at between '#{Date.today - params[:buyrange].to_i}' and '#{Date.today}'").buy_pitch
    respond_to do |format|
      format.js
    end
  end

end
