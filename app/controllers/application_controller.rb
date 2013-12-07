class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!

  #protect_from_forgery with: :exception

  #protect_from_forgery with: :null_session
  before_filter :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'new'
      'devise/layouts/signout'
    else
      "application"
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      flash[:error] = exception.message
      format.js { flash_to_headers }
      format.html { redirect_to root_path, :alert => exception.message }
    end
  end

  rescue_from(ActiveRecord::RecordNotFound) do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, :alert => "Invalid Access!" }
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :name, :mobilenumber, :roles, :email, :password, :password_confirmation
    end
  end



  private

  def get_records(class_name, params = {}, options = {:date_option => true})
    params[:sort_by] = 'asc' if params[:sort_by].blank?
    params[:range] = 10 if params[:range].blank?
    if options[:date_option]
      objs = class_name.where("created_at between '#{Date.today - params[:range].to_i}' and '#{Date.today} 23:59:59'")
    else
      objs = class_name.where("created_at between '#{Date.today - params[:range].to_i}' and '#{Date.today} 23:59:59'")
    end

    if params[:sort_by] == "following"
      companies = current_user.follows_by_type('Company').map(&:followable)
      objs = objs.where(:company_id => companies.map(&:id)).order("created_at desc")
    else
      objs = objs.order("created_at #{params[:sort_by]}")
    end
    objs
  end

  def flash_to_headers
    return unless request.xhr?
    response.headers['X-Message'] = flash_message
    response.headers["X-Message-Type"] = flash_type.to_s
    flash.discard # don't want the flash to appear when you reload page
  end

  def flash_message
    [:error, :warning, :notice].each do |type|
      return flash[type] unless flash[type].blank?
    end
  end

  def flash_type
    [:error, :warning, :notice].each do |type|
      return type unless flash[type].blank?
    end
  end

end
