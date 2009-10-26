class RegionsController < ApplicationController
  def list
    @regions = Region.paginate :per_page =>3, :page => params[:page], :order => 'name'
  end

  def index
    list2
    render :action => 'list2'
  end

  def list2
    @region_pages, @regions = paginate :regions, :per_page => 10
  end

  def regional_compensation_report
     	@report_lines = Region.regional_compensation_report 
  end

  def schema_report
     	@report_lines = Region.schema_report 
  end

end
