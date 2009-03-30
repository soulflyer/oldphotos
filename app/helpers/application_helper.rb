# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Rails assumes that images are in /images . This method returns the directory to be APPENDED to the default location
  def photo_root_directory
    "photos"
  end
  
  def stylesheets
    if session[:user_id]
      User.find(session[:user_id]).stylesheets
    else
      "default"
    end
  end
end
