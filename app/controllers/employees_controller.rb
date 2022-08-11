class EmployeesController < ApplicationController
  before_action :set_employee, only: [:index, :edit, :update]

  def index
    @groups = @employee.groups.includes(:posts)
    @groups = @groups.filter_groups(params[:group]) if params[:group].present?
  end

  def edit
  end

  def update
    if @employee.update_attributes(employee_params)
      bypass_sign_in(@employee)
      redirect_to employees_path
    else
      flash[:error] = "You didn't update password"
      render 'edit'
    end
  end

  def show_post
    @post = Post.find(params[:id])
  end

  private

  def set_employee
    @employee = current_user
  end

  def employee_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
