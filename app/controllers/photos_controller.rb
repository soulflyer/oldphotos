class PhotosController < ApplicationController
    
  # GET /photos
  # GET /photos.xml
  def index
    # @photos = Photo.find(:all)
    @photos = Photo.paginate :page => params[:page], :per_page => per_page, :order => 'updated_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  def new_batch
    flash[:notice]= ''
    # need to get the path in the following line from the helper method somehow....
    @folder_path = RAILS_ROOT + "/public/images/photos/"
    
    Dir.chdir(@folder_path)
    @dir_listing = Dir["*"]
    @listing = @dir_listing
    if params[:photo_dir]
      Dir.chdir(@folder_path + params[:photo_dir])
    end
    @listing = Dir["*.jpg"]
    
  rescue SystemCallError
#    flash[:notice]= 'Directory not found in ' + @folder_path
    flash[:notice]= "#$!"
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.xml
  def create
    @photo = Photo.new(params[:photo])
    @photo.extract_exif

    respond_to do |format|
      if @photo.save
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to(@photo) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def create_batch
    print :listing
    for file in params[:listing]
      logger.info( "hello ************************************ #{params[:photo_dir]} image_url #{file}")
      # create the photo entry. The decription field is passed here as a param with the name of the file
      photo = Photo.new(:image_dir => params[:photo_dir], :image_url => file, :description => params[file])
      photo.extract_exif
      
      if photo.save
        logger.info("Photo saved")
      else
        logger.info("save failed")
      end
    end
    redirect_to(:action => "index")
  end
  
  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(@photo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def per_page
    if session[:user_id]
      User.find(session[:user_id]).per_page
    else
      12
    end
  end
end
