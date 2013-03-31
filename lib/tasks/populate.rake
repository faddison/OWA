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
       
    Brochurelog.populate 50 do |brochurelog, b_index, f_index|
	
		b_index = 1..Brochure.count
		brochurelog.brochure_id = b_index
		brochurelog.bname = Brochure.find_by_id(b_index).name
		
		f_index = 1..Facility.count
		brochurelog.facility_id = f_index
		brochurelog.fname = Facility.find_by_id(f_index).name
		
        brochurelog.count = 1..20
        brochurelog.date = 1.years.ago..Time.now
		brochurelog.status = 'approved'
    end
	
	Referrallog.populate 50 do |referrallog, r_index, f_index|
		
		r_index = 1..Referral.count
		referrallog.referral_id = r_index
		referrallog.rname = Referral.find_by_id(r_index).name
		
		f_index = 1..Facility.count
		referrallog.facility_id = f_index
		referrallog.fname = Facility.find_by_id(f_index).name
		
        referrallog.count = 1..20
        referrallog.date = 1.years.ago..Time.now
		referrallog.status = 'approved'
    end
	
	Event.populate 50 do |event|
	
		event.title = Populator.words(3)
		event.program_id = 1..Program.count
		event.facility_id = 1..Facility.count
		event.eventtype_id = 1..Eventtype.count
        event.duration = 1..8
        event.date = 1.years.ago..Time.now
		event.status = 'approved'
    end
	
	Visitor.populate 100 do |visitor|
		first = Faker::Name.first_name
		last = Faker::Name.last_name
		visitor.fname = first
		visitor.lname = last
		visitor.fullname = first+' '+last
		visitor.language = Language::LANGUAGES.sample.to_s
		visitor.email = Faker::Internet.email
		visitor.phone = Faker::PhoneNumber.phone_number
		visitor.country = Faker::Address.country
		visitor.postcode = Faker::Address.zip_code
		visitor.ftime = 1.years.ago..Time.now
		visitor.status = 'approved'
	end
		
	
	Eventlog.populate 1000 do |eventlog, e_index, v_index|
		
		e_index = 1..Event.count
		eventlog.event_id = e_index
		eventlog.ename = Event.find_by_id(e_index).title
		
		v_index = 1..Visitor.count
		eventlog.visitor_id = v_index
		eventlog.vname = Visitor.find_by_id(v_index).fullname
		
		eventlog.status =  'approved'
	end	
		
	
  end
end