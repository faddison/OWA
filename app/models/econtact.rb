class Econtact < ActiveRecord::Base
  belongs_to :visitor
  attr_accessible :name, :phone, :relationship
end
