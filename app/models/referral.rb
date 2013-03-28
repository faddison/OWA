
class Referral < ActiveRecord::Base
  attr_accessible :name,:status
  validates :name,  :presence => true
  has_many :referrallogs, :dependent => :destroy
   def self.search(search)
		if search
			return find(:all, :conditions => ['name LIKE ? status LIKE ', "%#{search}%","%#{search}%"])
		else
			return find(:all)
		end
	end
  def self.to_csv(params)
		@records = Referral.search(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
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
