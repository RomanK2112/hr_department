class Admin::AdminsController < ActionController::Base
  before_action :authenticate_user!
  layout 'admin'

  def index
  end

  private

  def authenticate_user!
    redirect_to root_path, alert: 'Not authorized.' if !signed_in?
  end
end
