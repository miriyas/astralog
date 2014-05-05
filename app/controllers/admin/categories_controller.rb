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
    future_position = params[:to]
    
    if future_position.to_i == 0
      # UP or DOWN 문자로 들어왔을 때
      if category.parent?
        # 부모일때
        current_position = category.archposition
        if future_position == "down"
          target = Category.where("categories.archposition > #{current_position} AND categories.subject_id = #{category.subject_id} AND categories.parent_id IS ?", category.parent_id).first
        elsif future_position == "up"
          target = Category.where("categories.archposition < #{current_position} AND categories.subject_id = #{category.subject_id} AND categories.parent_id IS ?", category.parent_id).last
        end
        if target.present?
          category.update_attributes(archposition: target.archposition)
          target.update_attributes(archposition: current_position)
        else
          # 이미 맨 아래거나 맨 위라 아무것도 안함.
        end
      else
        # 자식일때
        current_position = category.position
        if future_position == "down"
          target = Category.where("categories.position > #{current_position} AND categories.subject_id = #{category.subject_id} AND categories.parent_id = ?", category.parent_id).first
        elsif future_position == "up"
          target = Category.where("categories.position < #{current_position} AND categories.subject_id = #{category.subject_id} AND categories.parent_id = ?", category.parent_id).last
        end
        if target.present?
          category.update_attributes(position: target.position)
          target.update_attributes(position: current_position)
        else
          # 이미 맨 아래거나 맨 위라 아무것도 안함.
        end
      end
      
    else
      #숫자로 왔을때
      future_position = future_position.to_i
      if category.parent?
        # 부모일때
        current_position = category.archposition
        if current_position == future_position
          # 현재 위치랑 같으므로 아무것도 안함.
        elsif current_position > future_position
          Category.where(archposition: future_position..current_position, subject: category.subject_id).update_all("archposition = archposition + 1")
        else
          Category.where(archposition: current_position..future_position, subject: category.subject_id).update_all("archposition = archposition - 1")
        end
        category.update_attributes(archposition: future_position)
      else
        # 자식일때
        current_position = category.position
        if current_position == future_position
          # 현재 위치랑 같으므로 아무것도 안함.
        elsif current_position > future_position
          Category.where(position: future_position..current_position, subject: category.subject_id).update_all("position = position + 1")
        else
          Category.where(position: current_position..future_position, subject: category.subject_id).update_all("position = position - 1")
        end
        category.update_attributes(position: future_position)
      end
    end
    redirect_to admin_categories_path
    
  end
  
private

  def category_params
    params.require(:category).permit(:name, :subject_id, :parent_id, :view_type, :archposition, :position, :role)
  end

end
