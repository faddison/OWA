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
       
    Brochurelog.populate 5 do |brochurelog, b_index, f_index|
		b_index = 1..Brochure.count
		f_index = 1..Facility.count
		brochurelog.brochure_id = b_index
		brochurelog.bname = Brochure.find_by_id(b_index).name
		brochurelog.facility_id = f_index
		brochurelog.fname = Brochure.find_by_id(f_index).name
        brochurelog.count = 1..20
        brochurelog.date = Time.now
    end
  end
end