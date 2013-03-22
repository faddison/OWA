class Eventlog < ActiveRecord::Base
  belongs_to :event
  belongs_to :visitor
  attr_accessible :event_id, :visitor_id, :ename, :vname
  
  def self.search(search)
		if search
			return find(:all, :conditions => ['ename LIKE ? or vname LIKE ?', "%#{search}%","#{search}"])
		else
			return find(:all)
		end
  end
  
end
