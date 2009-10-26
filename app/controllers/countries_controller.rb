class CountriesController < ApplicationController
  def list
      @countries = Country.paginate :per_page => 10, :page => params[:page], :order => 'name'
  end

  def list_region
      @countries = Country.paginate  :per_page => 10, :page => params[:page], :order => 'name',
        :conditions => [" region_id IN (SELECT id FROM regions WHERE name = ?)", params[:name]]
      render :action => 'list'
  end

  def index
    list2
    render :action => 'list2'
  end

  def list2
    @country_pages, @countries = paginate :countries, :per_page => 10
  end

  def list_region2
    @country_pages,  @countries = paginate(:countries, :conditions => [" region_id IN (SELECT id FROM regions WHERE name = ?)", params[:name] ])
    render( :template => 'countries/list2' )
  end
  
end
