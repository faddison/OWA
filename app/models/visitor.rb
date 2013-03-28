class Visitor < ActiveRecord::Base
  attr_accessible :email, :fname, :language, :lname, :phone, :fullname, :postcode, :country, :husband, :notes, :ftime,:status
  validates :fname,  :presence => true
  has_many :children,	:dependent => :destroy
  has_many :econtacts,   :dependent => :destroy
  has_many :eventlogs, :dependent => :destroy
	def self.full_name(fname,lname)
		[fname, lname].join(" ")
	end
	def self.to_csv(params)
		@records = Visitor.search(params[:search])
		CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |visitor|
				csv << visitor.attributes.values_at(*column_names)
			end
			csv << ["child ID","child name","allergies","parents name","parents id"]
			@records.each do |visitor|
				visitor.children.each do |child|
					csv << [child.id,child.name,child.allergies,child.visitor.fullname,child.visitor.id]
				end
			end
		end
	end
	def self.search(search)
		if search
			return find(:all, :conditions => ['fullname LIKE ? or email LIKE ? or fname LIKE ? or phone LIKE ? or language LIKE ? or status LIKE ?', "%#{search}%","#{search}","#{search}","#{search}","#{search}","#{search}"])
		else
			return find(:all)
		end
	end
	def self.connfinal
		establish_connection('finaldb')
	end
	def self.conndeve
		establish_connection('development')
	end
	def approval
		establish_connection('development')
		self.save
		establish_connection('finaldb')
	end
  
  
end
