class Visitor < ActiveRecord::Base
  attr_accessible :email, :fname, :language, :lname, :phone, :fullname
  validates :fname,  :presence => true
  has_many :children,	:dependent => :destroy
  
	def self.full_name(fname,lname)
		[fname, lname].join(" ")
	end
	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |visitor|
			csv << visitor.attributes.values_at(*column_names)
			end
		end
	end
	def self.search(search)
		if search
			return find(:all, :conditions => ['fullname LIKE ? or email LIKE ? or fname LIKE ? or phone LIKE ? or language LIKE ?', "%#{search}%","#{search}","#{search}","#{search}","#{search}"])
		else
			return find(:all)
		end
	end
  
  
  
end
