class Admin::CategoriesController < ApplicationController
	before_filter :require_admin
	layout 'admin'
	
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: '분류가 생성되었습니다.'
    else
			p @category.errors
      render action: 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: '분류가 수정되었습니다.'
    else
			p @category.errors
      render action: 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
		redirect_to admin_categories_path
  end
	
	def reload_parent_category
		p "SSSSSSSSSSSSSSSSSSSSS"
	end

  private
    def category_params
      params.require(:category).permit(:name, :subject_id, :parent_id, :view_type, :position, :role)
    end
end