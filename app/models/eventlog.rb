class Eventlog < ActiveRecord::Base
  belongs_to :event
  belongs_to :person
  attr_accessible :event_id, :person_id
end
