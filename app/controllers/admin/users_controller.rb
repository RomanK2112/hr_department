class Admin::UsersController < Admin::AdminsController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :toggle_admin]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_admins_path
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      redirect_to new_admin_user_path
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      bypass_sign_in(@user)
      redirect_to admin_user_path(@user)
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    if @user.present?
      @user.destroy
      redirect_back fallback_location: @user
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      redirect_back fallback_location: @user
    end
  end

  def toggle_admin
    @user.update_attributes(is_admin: !@user.is_admin?)
    redirect_back fallback_location: @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end
end
