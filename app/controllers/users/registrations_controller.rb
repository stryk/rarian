class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
    resource.roles = params[:user][:roles]
    resource.save
  end

end