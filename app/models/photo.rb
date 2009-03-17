#require 'exifr'
require 'mini_exiftool'

class Photo < ActiveRecord::Base
  validates_presence_of :image_url, :image_dir
  
  def exif
    # @exif = EXIFR::JPEG.new(self.image_url)
    @exif = MiniExiftool.new(self.image_url)
  end
  
end
