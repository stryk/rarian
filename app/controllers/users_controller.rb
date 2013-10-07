class UsersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :show

  def show

  end

  def setting

  end

end
