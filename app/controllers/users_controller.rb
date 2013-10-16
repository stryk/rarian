class UsersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :show

  def show

  end

  def new

  end

  def setting
    #raise User.new.no_day_newsletter.inspect
  end

  def credits

  end

  def update


  end


end
