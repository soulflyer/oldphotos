class Photo < ActiveRecord::Base
  validates_presence_of :title, :image_url, :image_dir
end
