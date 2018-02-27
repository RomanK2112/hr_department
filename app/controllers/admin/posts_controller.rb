class Admin::PostsController < Admin::AdminsController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_group, only: [:create]

  def index
    @posts = Post.all
  end

  def new
    @groups = Group.all
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(
      title: params[:post][:title],
      body: params[:post][:body],
      file: params[:file]
    )
    @post.user = current_user
    @group.posts.push(@post)

    if @post.save
      redirect_to admin_posts_path
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group])
  end
  
  def post_params
    params.require(:post).permit(:title, :body, :file)
  end
end
