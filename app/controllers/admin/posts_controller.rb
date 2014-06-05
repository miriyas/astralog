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
    p "POST NEW"
    if @new_post = PostDraft.where(post_id: nil).first
      @post = @new_post
    else
      @post = PostDraft.create(post_id: nil, user_id: current_user.id)
    end
  end

  def create
    p "POST CREATE"
    @post = Post.create(params[:draft_id])
    
    
    
    # @post = Post.new(post_params)
    # if @post.save
    #   redirect_to admin_posts_path, notice: 'Post was successfully created.'
    # else
    #   p @post.errors
    #   render action: 'new'
    # end
  end

  def edit
    p "POST EDIT"
    @post = Post.find(params[:id])
  end

  def update
    p "POST UPDATE"
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: 'Post was successfully updated.'
    else
      p @post.errors
      render action: 'edit'
    end
  end

  def auto_save
    @post = Post.find(params[:post_id])
    @post.update_attributes(post_params)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

private

  def post_params
    params.require(:post).permit(:user_id, :subject_id, :category_id, :title, :body, :tags, :status, :view_type, :main_image, :comment_permission)
  end

end