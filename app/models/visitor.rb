class Visitor < ActiveRecord::Base
  attr_accessible :email, :fname, :language, :lname, :phone
  validates :fname,  :presence => true
  has_many :children,	:dependent => :destroy
  
	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |visitor|
			csv << visitor.attributes.values_at(*column_names)
			end
		end
	end
  
  
  
end
