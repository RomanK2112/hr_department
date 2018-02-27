class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    current_user.is_admin ? admin_admins_path : employees_path(resource.id)
  end
end
