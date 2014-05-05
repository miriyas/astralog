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
  
  
  def reposition
    category = Category.find(params[:id])
    current_position = category.position
    future_position = params[:to]
    if future_position.to_i == 0
      # UP or DOWN 문자로 들어왔을 때
      if future_position == "down"
        c = Category.where("position > ? AND subject_id = ?", current_position, category.subject_id).first
      elsif future_position == "up"
        c = Category.where("position < ? AND subject_id = ?", current_position, category.subject_id).last
      end
      if c.present?
        category.update_attributes(position: c.position)
        c.update_attributes(position: current_position)
      else
        # 이미 맨 아래거나 맨 위라 아무것도 안함.
      end
    else
      # 숫자로 들어왔을 때
      future_position = future_position.to_i
      if current_position == future_position
        # 현재 위치랑 같으므로 아무것도 안함.
      elsif current_position > future_position
        Category.where(position: future_position..current_position, subject: category.subject_id).update_all("position = position + 1")
      else
        Category.where(position: current_position..future_position, subject: category.subject_id).update_all("position = position - 1")
      end
      category.update_attributes(position: future_position)
    end
    redirect_to admin_categories_path
  end
  
private

  def category_params
    params.require(:category).permit(:name, :subject_id, :parent_id, :view_type, :position, :role)
  end

end
