class LocationsController < ApplicationController
  def list
    @locations = Location.paginate :per_page => 10, :page => params[:page]
  end

  def list_country
    @locations = Location.paginate :per_page => 10, :page => params[:page],
            :conditions => [" country_id IN (SELECT country_id FROM countries WHERE name = ?)", params[:name] ]
    render :action => 'list'
  end

  def index
    list2
    render :action => 'list2'
  end

  def list2
    @location_pages, @locations = paginate :locations, :per_page => 10
  end

  def list_country2
    @location_pages,  @locations = paginate(:locations, :conditions => [" country_id IN (SELECT country_id FROM countries WHERE name = ?)", params[:name] ])
    render( :template => 'locations/list2' )
  end

  def new
    @countries = Country.find(:all, :order => "name") 
    @location = Location.new
  end

  def create
   @countries = Country.find(:all, :order => "name") 
   @location = Location.new(params[:location])
    if @location.save
      flash[:notice] = 'Location was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
   @countries = Country.find(:all, :order => "name") 
    @location = Location.find(params[:id])
  end

  def update
    @countries = Country.find(:all, :order => "name") 
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      flash[:notice] = 'Location '+@location.street_address+' was successfully updated.'
      redirect_to :action => 'list', :id => @location
    else
      render :action => 'edit'
    end
  end

  def destroy
   
    Location.find(params[:id]).destroy
flash[:notice] = 'Location was successfully deleted.'
    redirect_to :action => 'list'
  end
end
