# lib/tasks/populate.rake
#
# Rake task to populate development database with test data
# Run it with "rake db:populate"
# See Railscast 126 and the faker website for more information

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    

    Rake::Task['db:schema:load'].invoke 
    
    Visitor.populate 10 do |visitor|
      visitor.fname = Faker::Name.first_name
      visitor.lname = Faker::Name.last_name
      visitor.language = Populator.words(1).titleize
      visitor.email = Faker::Internet.email
      visitor.phone = Faker::PhoneNumber.phone_number
    end
    
#    Facility.populate 5 do |facility|
#      facility.name = Faker::Name.title
#      facility.name = Faker::Company.name
#      facility.address = Faker::Address.street_address
#    end
    
#    Brochure.populate 10 do |brochure|
#     brochure.name = Faker::Name.name
#    end
    
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
    
    #Program.populate 5 do |program|
      #program.name = Populator.words(1).titleize
      #end
    
    
#    Eventtype.populate 10 do |eventtype|
#      eventtype.name = Populator.words(1).titleize
#    end
    
#    Event.populate 10 do |event|
#      event.title = Populator.words(1)
#      event.duration = 1..3
#      event.date = Time.now
#      Eventtype.populate 1 do |eventtype|
#        eventtype.name = Populator.words(1)
#        event.eventtype_id = eventtype.id
#      end
#      Facility.populate 1 do |facility|
#        facility.name = Faker::Company.name
#        facility.address = Faker::Address.street_address
#        event.facility_id = facility.id
#      end
#       Program.populate 1 do |program| 
#         program.name = Populator.words(1).titleize
#        event.program_id = program.id
#      end
#    end
    
     Event.populate 2 do |event|
      event.title = Populator.words(1)
      event.duration = 1..3
      event.date = Time.now
      Eventtype.populate 1 do |eventtype|
        eventtype.name = Populator.words(1)
        event.eventtype_id = eventtype.id
      end
      Facility.populate 1 do |facility|
        facility.name = Faker::Company.name
        facility.address = Faker::Address.street_address
        event.facility_id = facility.id
      end
      Program.populate 1 do |program| 
        program.name = Populator.words(1).titleize
        event.program_id = program.id
      end
    end
      
      Visitor.populate 4 do |visitor|
        visitor.fname = Faker::Name.first_name
      end
    end
  end