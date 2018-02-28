class EmployeesController < ApplicationController
  before_action :set_employee, only: [:index, :edit, :update]

  def index
    @groups = @employee.groups.includes(:posts)
    @groups = @groups.filter_groups(params[:group]) if params[:group].present?
  end

  def edit
  end

  def update
    if @employee.valid_password?(params[:user][:current_password]) && @employee.update_attributes(user_params)
      bypass_sign_in(@employee)
      redirect_to employees_path
    else
      flash[:error] = "You didn't update password"
      render 'edit'
    end
  end

  private

  def set_employee
    @employee = current_user
  end
end
