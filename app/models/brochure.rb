class Brochure < ActiveRecord::Base
  belongs_to :brochurelog
  attr_accessible :name
end
