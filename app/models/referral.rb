
class Referral < ActiveRecord::Base
  attr_accessible :name,:status
  validates :name,  :presence => true
  has_many :referrallogs, :dependent => :destroy
  
  def self.to_csv(params)
		@records = Referral.metasearch(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end
	
end
