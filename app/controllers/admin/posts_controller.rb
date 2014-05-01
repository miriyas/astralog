class Admin::PostsController < ApplicationController
  before_filter :require_admin
  layout 'admin'
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to admin_posts_path, notice: 'Post was successfully created.'
    else
      p @post.errors
      render action: 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: 'Post was successfully updated.'
    else
      p @post.errors
      render action: 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url
  end

private

  def post_params
    params.require(:post).permit(:user_id, :subject_id, :category_id, :title, :body, :tags, :status, :view_type, :main_image, :comment_permission)
  end

end