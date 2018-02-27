class Admin::GroupsController < Admin::AdminsController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :add_member, :destroy_member]

  def index
    @groups = Group.all
    @users = User.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to admin_groups_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to admin_groups_path
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to admin_groups_path
  end

  def add_member
    user = User.find(params[:user])
    if user.present?
      @group.users.push(user)
      flash[:notice] = 'You add new member'
    else
      flash[:error] = 'This user already present in this group'
    end

    redirect_to admin_groups_path
  end

  def destroy_member
    user = User.find(params[:user])
    if user.present?
      @group.users.destroy(user)
      flash[:notice] = 'You destroyed member'
    else
      flash[:error] = 'This user already present in this group'
    end

    redirect_to admin_groups_path
  end

  private

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name, :description)
    end
end
