class Child < ActiveRecord::Base
  belongs_to :visitor
  attr_accessible :name, :allergies
  validates :name,  :presence => true
end
