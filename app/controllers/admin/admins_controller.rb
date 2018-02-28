class Admin::AdminsController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_admin, only: [:edit, :update]
  layout 'admin'

  def index
    @groups = Group.all.includes(:posts)
    @groups = @groups.filter_groups(params[:group]) if params[:group].present?
  end

  def edit
  end

  def update
    if @admin.valid_password?(params[:user][:current_password]) && @admin.update_attributes(user_params)
      bypass_sign_in(@admin)
      redirect_to admin_admins_path
    else
      flash[:error] = "You didn't update password"
      render 'edit'
    end
  end

  private

  def set_admin
    @admin = current_user
  end

  def authenticate_user!
    redirect_to root_path, alert: 'Not authorized.' if !signed_in?
  end
end
