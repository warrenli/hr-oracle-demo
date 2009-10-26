class Job < ActiveRecord::Base
  set_primary_key :job_id

  has_many :employee
end
