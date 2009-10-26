class Location < ActiveRecord::Base
  belongs_to :country
  has_many :department

  validates_length_of :street_address, :maximum => 40
  validates_length_of :postal_code, :maximum => 12
  validates_length_of :city, :maximum => 30
  validates_length_of :locale, :maximum => 25
  validates_presence_of :city  
end
