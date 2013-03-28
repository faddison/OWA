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
    
    Visitor.populate 10 do |visitor|
      visitor.fname = Faker::Name.first_name
      visitor.lname = Faker::Name.last_name
      visitor.language = Populator.words(1).titleize
      visitor.email = Faker::Internet.email
      visitor.phone = Faker::PhoneNumber.phone_number
    end
    
    Facility.populate 5 do |facility|
      facility.name = Faker::Name.title
      facility.name = Faker::Company.name
      facility.address = Faker::Address.street_address
    end
    
    Brochure.populate 10 do |brochure|
     brochure.name = Faker::Name.name
    end
    
    Brochurelog.populate 6 do |brochurelog|
      Brochure.populate 3 do |brochure|
        brochure.name = Faker::Name.name
        brochurelog.brochure_id = brochure.id
        brochurelog.count = 1..50
        brochurelog.date = Time.now
        Facility.populate 1 do |facility|
          brochurelog.facility_id = facility.id
          facility.name = Faker::Company.name
          facility.address = Faker::Address.street_address
        end
      end
    end
    
    Program.populate 5 do |program|
      program.name = Populator.words(1).titleize
     end
    
    Referral.populate 10 do |referral|
      referral.name = Populator.words(1)
    end
    
    Eventtype.populate 10 do |eventtype|
      eventtype.name = Populator.words(1).titleize
    end

    
  end
end