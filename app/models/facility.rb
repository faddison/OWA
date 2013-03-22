class Facility < ActiveRecord::Base
  attr_accessible :address, :name
	def self.search(search)
		if search
			return find(:all, :conditions => ['name LIKE ? or address LIKE ?', "%#{search}%","%#{search}%"])
		else
			return find(:all)
		end
	end
	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end
	
  end
