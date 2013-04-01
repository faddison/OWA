
class Brochure < ActiveRecord::Base
  attr_accessible :name,:status
  has_many :brochurelogs, :dependent => :destroy
  
  def self.to_csv(params)
		@records = Brochure.metasearch(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end
	
end
