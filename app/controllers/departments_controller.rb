class DepartmentsController < ApplicationController
  def list
    @departments = Department.paginate :per_page => 10, :page => params[:page], :order => 'name'
  end

  def list_location
    @departments = Department.paginate :per_page => 10, :page => params[:page], :order => 'name',
        :conditions => [" location_id IN (SELECT id FROM locations WHERE street_address = ?)", params[:name] ]
    render :action => 'list'
  end

  def index
    list2
    render :action => 'list2'
  end

  def list_location2
    @department_pages,  @departments = paginate(:departments, :conditions => [" location_id IN (SELECT id FROM locations WHERE street_address = ?)", params[:name] ])
    render( :template => 'departments/list2' )
  end

   def list2
    @department_pages, @departments = paginate :departments, :per_page => 10
  end

  def new
    @managers = Employee.find(:all, :order => "last_name") 
    @department = Department.new
  end

  def create
    @managers = Employee.find(:all, :order => "last_name") 
    @department = Department.new(params[:department])
    if @department.save
      flash[:notice] = 'Department was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @managers = Employee.find(:all, :order => "last_name") 
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    @managers = Employee.find(:all, :order => "last_name") 
    if @department.update_attributes(params[:department])
      flash[:notice] = 'Department ' + @department.name + ' was successfully updated.'
      redirect_to :action => 'list', :id => @department
    else
      render :action => 'edit'
    end
  end

  def destroy
   
    if Department.find(params[:id]).has_employee?
          flash[:notice] = 'Department cannot be deleted while employees are associated.'
    else
	    Department.find(params[:id]).destroy
	    flash[:notice] = 'Department was successfully deleted.'
    end

    redirect_to :action => 'list'
  end
end
