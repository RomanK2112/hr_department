class Admin::AdminsController < ActionController::Base
  before_action :authenticate_user!
  layout 'admin'

  def index
    @groups = Group.all.includes(:posts)
    @groups = @groups.filter_groups(params[:group]) if params[:group].present?
  end

  private

  def authenticate_user!
    redirect_to root_path, alert: 'Not authorized.' if !signed_in?
  end
end
