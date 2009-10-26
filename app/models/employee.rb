class Employee < ActiveRecord::Base
  belongs_to :department
  belongs_to   :manager,
      :class_name => "Employee",
      :foreign_key => "manager_id"
  belongs_to :job
  has_many :managed_employee,
         :class_name => "Employee",
         :foreign_key => "manager_id"

  validates_presence_of :email, :hire_date, :last_name, :first_name, :phone_number, :salary
  validates_uniqueness_of :email
  validates_length_of :first_name, :maximum => 20
  validates_length_of :last_name, :maximum => 25
  validates_length_of :email, :maximum => 25
  validates_length_of :phone_number, :maximum => 20
  validates_numericality_of :salary, :only_integer => true

  def validate
    if salary != nil
      if salary < 1
        errors.add(:salary, "must be positive.")
      end

      if salary > 999999
        errors.add(:salary,"must be less than 999999")
      end
    end

    if commission !=nil

      unless commission >= 0 && commission < 1
        errors.add(:commission, "must be greater than 0 and less than 1.")
      end

    end
  end

  def self.all_managers
    Employee.find_by_sql(   " SELECT * " +
         " FROM employees " +
         " WHERE id IN " +
         "  ( " +
         "    SELECT distinct(manager_id)"+
         "   FROM employees "+
         " ) " +
         " ORDER BY last_name, first_name "
         )
  end

  def self.coporate_hierarchy
    Employee.find_by_sql(
        " SELECT tree.*,  "+
        "      LEAD (hierarchy_level) OVER (ORDER BY seq) next_level "+
        " FROM  "+
        " ( "+
        " SELECT  "+
        "      CONNECT_BY_ROOT last_name top_node_name "+
        "      ,(last_name || ', ' || first_name ||' ('||job_title||')') employee_name "+
        "        , emp.id employee_id "+        
        "      ,SYS_CONNECT_BY_PATH (last_name, '->') node_path  "+
        "      ,LEVEL hierarchy_level "+
        "      ,ROWNUM seq "+
        " FROM  "+
        "    ( "+
        "    SELECT e.*, j.job_title  "+
        "    FROM employees e, jobs j "+ 
        "    WHERE e.job_id = j.job_id "+
        "    ) emp    "+
        " START WITH emp.job_title= 'President' "+
        " CONNECT BY PRIOR emp.id = manager_id "+
        " ORDER SIBLINGS BY emp.id "+
        " ) tree "+
        " order by seq"
    )
  end

end
