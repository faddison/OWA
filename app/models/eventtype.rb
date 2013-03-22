class Eventtype < ActiveRecord::Base
  attr_accessible :name
  def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << ['event name']
			all.each do |f|
				csv << [f.name]
			end
		end
	end
	def self.search(search)
		if search
			return find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
		else
			return Eventtype.all
		end
	end
end
