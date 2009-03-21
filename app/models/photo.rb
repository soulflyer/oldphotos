#require 'exifr'
require 'mini_exiftool'

class Photo < ActiveRecord::Base
  validates_presence_of :image_url, :image_dir
  
  def exif
    # @exif = EXIFR::JPEG.new(self.image_url)
    @exif = MiniExiftool.new( RAILS_ROOT + "/public/images/photos/" + self.image_dir + "/" + self.image_url)
  end
  
  def exifdate
    if (self.exif.timedateoriginal)
      @exifdate = Time.parse self.exif.timedateoriginal.to_s
    else
      @exifdate = Time.parse self.exif.modifydate.to_s
    end
  end
  
end
