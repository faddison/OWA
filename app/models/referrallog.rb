class Referrallog < ActiveRecord::Base
  belongs_to :referral
  belongs_to :facility
  attr_accessible :count, :date, :facility_id, :referral_id, :fname, :rname
  validates :date,  :presence => true
  validates :facility_id,  :presence => true
  validates :referral_id,  :presence => true
  validates :fname,  :presence => true
  validates :rname,  :presence => true
  def self.to_csv(params)
		@records = Referrallog.search(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end
	def self.search(search)
		if search
			return find(:all, :conditions => ['count LIKE ? or rname LIKE ? or fname LIKE ?', "%#{search}%","#{search}","#{search}"])
		else
			return Referrallog.all
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
