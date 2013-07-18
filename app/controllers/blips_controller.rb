class BlipsController < ApplicationController
  load_and_authorize_resource

  def create
    Blip.create(params[:blip])
    respond_to do |format|
      format.js
    end
  end
end
