class Country < ActiveRecord::Base
  set_primary_key :country_id

  belongs_to :region
  has_many  :location
end
