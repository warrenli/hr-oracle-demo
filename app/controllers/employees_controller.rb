class EmployeesController < ApplicationController
  def list
    @employees = Employee.paginate :per_page => 20, :page => params[:page], :order => 'first_name, last_name'
  end

  def list_department
    @employees = Employee.paginate :per_page => 20, :page => params[:page], :order => 'first_name, last_name',
        :conditions => [" id IN (SELECT id FROM employees WHERE manager_id = ?)", params[:id] ]
    @name = "Manager: " +Employee.find(params[:id]).first_name + " " +Employee.find(params[:id]).last_name
    render :action => 'list'
  end

  def index
    list2
    render :action => 'list2'
  end

  def list2
    @employee_pages, @employees = paginate :employees, :per_page => 10
  end

  def list_department2
    @employee_pages,  @employees = paginate(:employees, :conditions => [" id IN (SELECT id FROM employees WHERE manager_id = ?)", params[:id] ])
    @name = "Manager: " +Employee.find(params[:id]).first_name + " " +Employee.find(params[:id]).last_name
    render( :template => 'employees/list2' )
   
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @managers = Employee.all_managers 
    @jobs=Job.find(:all, :order=>"job_title")
    @departments=Department.find(:all, :order => "name")
    @employee = Employee.new
  end

  def create
    @managers = Employee.all_managers 
    @jobs=Job.find(:all, :order=>"job_title")
    @departments=Department.find(:all, :order => "name")
    @employee = Employee.new(params[:employee])
    if @employee.save
      flash[:notice] = 'Employee was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @jobs=Job.find(:all, :order=>"job_title")
    @managers = Employee.all_managers 
    @departments=Department.find(:all, :order => "name")
    @employee = Employee.find(params[:id])
  end

  def update
    @jobs=Job.find(:all, :order=>"job_title")
    @managers = Employee.all_managers 
    @departments=Department.find(:all, :order => "name")
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(params[:employee])
      flash[:notice] = 'Employee ' + @employee.first_name+' '+  @employee.last_name + ' was successfully updated.'
      redirect_to :action => 'list', :id => @employee
    else
      render :action => 'edit'
    end
  end

  def destroy
    Employee.find(params[:id]).destroy
    flash[:notice] = 'Employee was successfully deleted.'      
    redirect_to :action => 'list'
  end
  
  def corporate_hierarchy_tree
    @nodes=Employee.coporate_hierarchy
  end
  
end
