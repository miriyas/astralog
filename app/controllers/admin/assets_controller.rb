class Admin::AssetsController < ApplicationController

  before_filter :require_admin
  layout 'admin'

  def index
    @assets = Asset.page(params[:page]).order("created_at desc").per(20)
  end

  def create
    _filedata = params[:asset][:filedata]
    _filename = params[:asset][:filedata].original_filename
    if MIME::Types.type_for(_filename).present?
      _content_type = MIME::Types.type_for(_filename).first.content_type
    else
      # 주의 : 실제 파일 타입이 아닐 경우 공격 가능하지 않을지.. 서버사이드로 파일 확장자 탐지가 필요할듯.. 
      # ruby-filemagic 이라는 잼이 있는데 호환 안되더라..
      _content_type = File.extname(_filename)
    end
    (class << _filedata; self; end;).class_eval { define_method(:content_type) { _content_type }; define_method(:filename) { _filename }; define_method(:original_filename) { _filename } }
    @asset = Asset.new( filedata: _filedata, user_id: current_user.id)

    if @asset.save
      render :layout => false
    else
    end
  end
  
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
    redirect_to admin_assets_path
  end
  
end
