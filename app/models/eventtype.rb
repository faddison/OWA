
class Eventtype < ActiveRecord::Base
  attr_accessible :name,:status
  validates :name,  :presence => true
  has_many :events, :dependent => :destroy
    def self.to_csv(params)
		@records = Eventtype.metasearch(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << ['event name']
			@records.each do |f|
				csv << [f.name]
			end
		end
	end
	
	
end
