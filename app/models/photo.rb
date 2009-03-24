#require 'exifr'
require 'mini_exiftool'

class Photo < ActiveRecord::Base
  validates_presence_of :image_url, :image_dir
  
  def exif
    # @exif = EXIFR::JPEG.new(self.image_url)
    @exif = MiniExiftool.new( RAILS_ROOT + "/public/images/photos/" + self.image_dir + "/" + self.image_url)
  end
  
  # redo extract_exif
  def extract_exif
    if (self.exif)
      self.iso = self.exif.iso
      self.shutterspeed = self.exif.shutterspeed
      self.aperture = self.exif.aperture
      self.focallength = self.exif.focallength
      self.date = self.exifdate
    end
  end
  
  def exifdate
    if (self.exif.timedateoriginal)
      @exifdate = Time.parse self.exif.timedateoriginal.to_s
    else
      @exifdate = Time.parse self.exif.modifydate.to_s
    end
  end
  
end
