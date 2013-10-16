class HomeController < ApplicationController
  def index

  end
  def landing
    @blips = Blip.order("created_at DESC")
    @catalyst = Catalyst.order("date DESC").group_by(&:date)
  end

end
