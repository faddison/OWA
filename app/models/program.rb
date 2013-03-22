class Program < ActiveRecord::Base
  attr_accessible :name
  def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << ['eventtype name']
			all.each do |f|
				csv << [f.name]
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
