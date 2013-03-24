class Econtact < ActiveRecord::Base
  belongs_to :visitor
  attr_accessible :name, :phone, :relationship
  validates :name,  :presence => true
  validates :phone, :presence => true
end
