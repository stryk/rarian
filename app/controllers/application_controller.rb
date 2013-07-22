class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      flash.now[:alert] = exception.message
      format.js { render :js => "window.location.href = '#{root_path}'",:alert => exception.message}
      format.html {redirect_to root_path, :alert => exception.message}
    end


  end

  protected


end
