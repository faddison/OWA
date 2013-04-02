 #lib/tasks/populate.rake

 #Rake task to populate development database with test data
 #Run it with "rake db:populate"
 #See Railscast 126 and the faker website for more information

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
	
    #Rake::Task['db:reset'].invoke
		#Rake::Task['db:seed'].invoke 
		#Rake::Task['db:fielddisplay'].invoke 
		#Rake::Task['db:abbreviation'].invoke 
       
    Brochurelog.populate 50 do |brochurelog|
	
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
	
		puts 'Creating Referrallogs...'
		num = 0
    while (num < 50)  do
			num = num + 1
			rid = rand(Referral.count)
			fid = rand(Facility.count)
			count = rand(20)
      Referrallog.create(:referral_id => rid,:facility_id => fid,:count => count,:date => 1.years.ago..Time.now,:status => ['approved', 'not approved'])
    end
	
	Event.populate 50 do |event, p_index, f_index, et_index|
	
		event.title = Populator.words(3)
		
		p_index = 1..Program.count
		program = Program.find_by_id(p_index)
		event.program_id = p_index
		event.pname = program.name
		
		f_index = 1..Facility.count
		facility = Facility.find_by_id(f_index)
		event.facility_id = f_index
		event.fname = facility.name
		
		et_index = 1..Eventtype.count
		eventtype = Eventtype.find_by_id(et_index)
		event.eventtype_id = et_index
		event.etname = eventtype.name
		
		event.duration = 1..8
		event.date = 1.years.ago..Time.now
		event.status = 'approved'
   end
	
	Visitor.populate 50 do |visitor|
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
		
	
	Eventlog.populate 100 do |eventlog, e_index, v_index|
		
		e_index = 1..Event.count
		eventlog.event_id = e_index
		event = Event.find_by_id(e_index)
		eventlog.ename = event.title
		eventlog.edate = event.date
		
		v_index = 1..Visitor.count
		eventlog.visitor_id = v_index
		eventlog.vname = Visitor.find_by_id(v_index).fullname
		
		eventlog.status =  'approved'
	end	
		
	
  end
end