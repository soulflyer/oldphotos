class Photo < ActiveRecord::Base
  validates_presence_of :image_url, :image_dir
end
