# == Schema Information
#
# Table name: assets
#
#  id              :integer(4)      not null, primary key
#  filename        :string(255)
#  screen_filename :string(255)
#  content_type    :string(255)
#  filesize        :string(255)
#  dimensions      :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Asset < ActiveRecord::Base

  before_create :force_set_created_at
  after_create :touch_asset
  belongs_to :user
  
  def is_image?
    !/image/i.match(self.content_type).blank?
  end

  def created_at_to_path
    "#{self.created_at.year}/#{self.created_at.month}/#{self.created_at.day}"
  end

  def url(style = nil)
    style ||= :original
    if style.to_s == "file"
      "/system/assets/#{self.created_at_to_path}/#{self.id}/#{self.filename}"
    else
      "/system/assets/#{self.created_at_to_path}/#{self.id}/#{style.to_s}_#{self.filename}"
    end
  end

  def path(style = nil)
    dir = "#{Rails.root.to_s}/public/system/assets/#{self.created_at_to_path}/#{self.id}"

    style.blank? ? dir : "#{dir}/#{style.to_s}_#{self.filename}"
  end

  def filedata=(_filedata)
    if _filedata
      @new_asset = Time.now.to_f.to_s.gsub(/[^0-9]/,'')
      FileUtils.mkdir_p("/tmp/#{@new_asset}")
      self.content_type = _filedata.content_type
      self.filesize = _filedata.size
      self.filename = _filedata.original_filename.force_encoding("UTF-8")
      if /image/i.match(_filedata.content_type).blank?
        store_file(_filedata)
      else
        store_image(_filedata)
      end
    end
  end

protected

  def store_image(_filedata)
    img = MiniMagick::Image.read(_filedata.read)
    rthumbs = [
      { :name => 'original', :size => "2560x2560>" },
      { :name => 'thumb80', :size => "80x80!" },
      { :name => 'thumb160', :size => "160x160!" }
    ].each do |rt|
      self.dimensions = "#{img[:width]}x#{img[:height]}" if rt[:name] == 'original'
      img.resize rt[:size]
      img.write "/tmp/#{@new_asset}/#{rt[:name]}_#{self.filename}"
    end
    # img.destroy!
  end

  def store_file(_filedata)
    File.open("/tmp/#{@new_asset}/#{self.filename}", "wb") {|f| f.write(_filedata.read)}
  end

  def force_set_created_at
    self.created_at = Time.now
  end

  def touch_asset
    if @new_asset
      FileUtils.mkdir_p(self.path)
      FileUtils.mv(Dir.glob("/tmp/#{@new_asset}/*.*"), self.path)
    end
  end

end
