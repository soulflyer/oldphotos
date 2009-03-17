# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Rails assumes that images are in /images . This method returns the directory to be APPENDED to the default location
  def photo_root_directory
    "photos"
  end
end
