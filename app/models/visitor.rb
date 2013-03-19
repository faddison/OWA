class Visitor < ActiveRecord::Base
  attr_accessible :email, :fname, :language, :lname, :phone
  validates :fname,  :presence => true
  has_many :children,	:dependent => :destroy
end
