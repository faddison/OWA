class Brochure < ActiveRecord::Base
  attr_accessible :name
  def self.search(search)
		if search
			return find(:all, :conditions => ['name LIKE ? ', "%#{search}%"])
		else
			return find(:all)
		end
	end
  def self.to_csv(params)
		@records = Brochure.search(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end
end
