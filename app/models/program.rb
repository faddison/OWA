class Program < ActiveRecord::Base
  attr_accessible :name
  validates :name,  :presence => true
  def self.to_csv(params)
		@records = Program.search(params[:search])
			CSV.generate(col_sep: "\t") do |csv|
			csv << column_names
			@records.each do |f|
				csv << f.attributes.values_at(*column_names)
			end
		end
	end
  def self.search(search)
		if search
			return find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
		else
			return Program.all
		end
  end
  
  
end
