class Admin::SubjectsController < ApplicationController
  before_filter :require_admin
  layout 'admin'
  
  def index
    @subjects = Subject.all
  end

  def new
    @subject = Subject.new
  end
  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      redirect_to admin_subjects_path, notice: '주제가 생성되었습니다.'
    else
      p @subject.errors
      render action: 'new'
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end
  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
      redirect_to admin_subjects_path, notice: '주제가 수정되었습니다.'
    else
      p @subject.errors
      render action: 'edit'
    end
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    redirect_to admin_subjects_path
  end

private

  def subject_params
    params.require(:subject).permit(:name, :style)
  end

end