
class Facility < ActiveRecord::Base
  attr_accessible :address, :name, :status
  validates :name,  :presence => true
  validates :address, :presence => true
  has_many :eventlogs, :dependent => :destroy
  has_many :brochurelogs, :dependent => :destroy
  has_many :referrallogs, :dependent => :destroy
	
	def self.to_csv(params)
		@records = Facility.metasearch(params[:search])
			@records = Facility.metasearch(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end
	
  end
