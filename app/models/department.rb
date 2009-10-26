class Department < ActiveRecord::Base
  belongs_to :manager,
    :class_name => "Employee",
    :foreign_key => "manager_id"
  belongs_to :location
  has_many :employee

  validates_presence_of :name #, :manager_id
  validates_uniqueness_of :manager_id, :message => " can only be assigned to a single department.", :unless => :has_no_manager
  validates_uniqueness_of :name, :message => " already exists."

  def has_no_manager
    self.manager_id.nil?
  end

  def has_employee?
    employees = Employee.find_all_by_department_id(self.id).length > 0
  end
end
