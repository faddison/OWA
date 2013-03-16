class Brochurelog < ActiveRecord::Base
  belongs_to :facility
  attr_accessible :count, :date, 
end
