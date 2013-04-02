 #lib/tasks/populate.rake

 #Rake task to populate development database with test data
 #Run it with "rake db:populate"
 #See Railscast 126 and the faker website for more information

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
	
    Rake::Task['db:reset'].invoke
		Rake::Task['db:seed'].invoke
		Rake::Task['db:fielddisplay'].invoke
		Rake::Task['db:abbreviation'].invoke
		
		@status = ['approved', 'not approved']
       
		puts "Populating Brochurelog..."
    Brochurelog.populate 50 do |brochurelog|
		
			brochurelog.brochure_id = 1..Brochure.count
			brochurelog.bname = Brochure.find_by_id(brochurelog.brochure_id).name
			
			brochurelog.facility_id = 1..Facility.count
			brochurelog.fname = Facility.find_by_id(brochurelog.facility_id).name
			
			brochurelog.count = 1..20
			brochurelog.date = 1.years.ago..Time.now
			brochurelog.status = @status
    end
	
		puts "Populating Referrallog..."
		Referrallog.populate 50 do |referrallog|
		
			referrallog.referral_id = 1..Referral.count
			referrallog.rname = Referral.find_by_id(referrallog.referral_id).name
			
			referrallog.facility_id = 1..Facility.count
			referrallog.fname = Facility.find_by_id(referrallog.facility_id).name
			
			referrallog.count = 1..20
			referrallog.date = 1.years.ago..Time.now
			referrallog.status = @status
			end
		
		puts "Populating Event..."
		Event.populate 50 do |event|
		
			event.name = Populator.words(3)
			
			event.program_id = 1..Program.count
			event.pname = Program.find_by_id(event.program_id).name
			
			event.facility_id = 1..Facility.count
			event.fname = Facility.find_by_id(event.facility_id).name
			
			event.eventtype_id = 1..Eventtype.count
			event.etname = Eventtype.find_by_id(event.eventtype_id).name
			
			event.duration = 1..8
			event.date = 1.years.ago..Time.now
			event.status = @status
			end
		
		puts "Populating Visitor..."
		Visitor.populate 50 do |visitor|
		
			first = Faker::Name.first_name
			last = Faker::Name.last_name
			
			visitor.fname = first
			visitor.lname = last
			visitor.name = first+' '+last
			visitor.language = Language::LANGUAGES.sample.to_s
			visitor.email = Faker::Internet.email
			visitor.phone = Faker::PhoneNumber.phone_number
			visitor.country = Faker::Address.country
			visitor.postcode = Faker::Address.zip_code
			visitor.ftime = 1.years.ago..Time.now
			visitor.status = @status
			
		end
			
		puts "Populating Eventlog..."
		Eventlog.populate 100 do |eventlog|
		
			eventlog.event_id = 1..Event.count
			eventlog.ename = Event.find_by_id(eventlog.event_id).name
			eventlog.date = Event.find_by_id(eventlog.event_id).date
			
			eventlog.visitor_id = 1..Visitor.count
			eventlog.vname = Visitor.find_by_id(eventlog.visitor_id).name
			
			eventlog.status = @status
		end	
		
	
  end
end