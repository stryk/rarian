class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "ap", password: "money", except: :index
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

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
      format.html { redirect_to root_path }
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :name, :mobilenumber, :roles, :email, :password, :password_confirmation
    end
  end



  private

  def get_records(class_name, params = {}, options = {})
    params[:sort_by] = 'default' if params[:sort_by].blank?
    if params[:sort_by] == "default"
      order_by_sql = <<-SQL
      CASE WHEN created_at between '#{Date.today - 7}' and '#{Date.today + 1}' and net_votes >= 0 THEN 1
           WHEN created_at between '#{Date.today - 14}' and '#{Date.today - 7}' and net_votes >= 1 THEN 2
           WHEN created_at between '#{Date.today - 21}' and '#{Date.today - 14}' and net_votes >= 5 THEN 3
           WHEN created_at between '#{Date.today - 30}' and '#{Date.today - 21}' and net_votes >= 10 THEN 4
           WHEN created_at between '#{Date.today - 60}' and '#{Date.today - 30}' and net_votes >= 20 THEN 5
           WHEN created_at between '#{Date.today - 90}' and '#{Date.today - 60}' and net_votes >= 40 THEN 6
           ELSE 7
      END
      SQL
      if options[:type] == 'longpitchs'
        objs = class_name.where('net_votes >= -1').order(order_by_sql, "net_votes desc, created_at desc").paginate(:page => params[:lp_page])
      elsif options[:type] == 'shortpitchs'
        objs = class_name.where('net_votes >= -1').order(order_by_sql, "net_votes desc, created_at desc").paginate(:page => params[:sp_page])
      else
        objs = class_name.where('net_votes >= -1').order(order_by_sql, "net_votes desc, created_at desc").paginate(:page => params[:blp_page])
      end

    elsif params[:sort_by] == "following"
      companies = current_user.follows_by_type('Company').map(&:followable)
      if options[:type] == 'longpitchs'
        objs = class_name.where(:company_id => companies.map(&:id)).order("created_at desc").paginate(:page => params[:lp_page])
      elsif options[:type] == 'shortpitchs'
        objs = class_name.where(:company_id => companies.map(&:id)).order("created_at desc").paginate(:page => params[:sp_page])
      else
        objs = class_name.where(:company_id => companies.map(&:id)).order("created_at desc").paginate(:page => params[:blp_page])
      end
    else
      if options[:type] == 'longpitchs'
        objs = class_name.order("created_at #{params[:sort_by]}").paginate(:page => params[:lp_page])
      elsif options[:type] == 'shortpitchs'
        objs = class_name.order("created_at #{params[:sort_by]}").paginate(:page => params[:sp_page])
      else
        objs = class_name.order("created_at #{params[:sort_by]}").paginate(:page => params[:blp_page])
      end      
    end
    return objs

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
