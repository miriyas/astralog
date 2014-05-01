class Admin::CommentsController < ApplicationController
	before_filter :require_admin
	layout 'admin'
	
  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end
  def create
    params[:comment][:user_ip] = request.remote_ip
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to admin_comments_path, notice: 'Comment was successfully created.'
    else
			p @comment.errors
      render action: 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to admin_comments_path, notice: 'Comment was successfully updated.'
    else
			p @comment.errors
      render action: 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :user_ip, :post_id, :body, :status, :role, :parent_id)
  end
end