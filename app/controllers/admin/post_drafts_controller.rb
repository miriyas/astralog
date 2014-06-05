class Admin::PostDraftsController < ApplicationController
  before_filter :require_admin
  layout 'admin'
  
  def update
    p "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    p "POSTDRAFT UPDATE"
    @post = Post.new(post_draft_params)
    if @post.save
      PostDraft.find(params[:id]).destroy
      redirect_to admin_posts_path, notice: '글이 작성되었습니다.'
    else
      p @post.errors
      render action: 'edit'
    end
  end
  
  def auto_save
    p "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    @post = PostDraft.find(params[:post_draft_id])
    @post.update_attributes(post_draft_params)
    render :nothing => true
  end
  
private

  def post_draft_params
    params.require(:post_draft).permit(:user_id, :subject_id, :category_id, :title, :body, :tags, :status, :view_type, :main_image, :comment_permission)
  end

end