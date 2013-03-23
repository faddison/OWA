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
    

    Rake::Task['db:reset'].invoke 
    
    Visitor.populate 20 do |visitor|
      visitor.fname = Faker::Name.first_name
      visitor.lname = Faker::Name.last_name
      visitor.language = Populator.words(1).titleize
      visitor.email = Faker::Internet.email
      visitor.phone = Faker::PhoneNumber.phone_number
    
    end
    
    Facility.populate 10 do |facility|
      facility.name = Faker::Name.title
      facility.address = Faker::Address.street_address
    end
    
    Brochure.populate 10 do |brochure|
      brochure.name = Faker::Name.name
    end
    
    Referral.populate 10 do |referral|
      referral.name = Faker::Name.name
    end
    
    Program.populate 10 do |program|
      program.name = Faker::Name.name
    end
    
    Eventtype.populate 10 do |eventtype|
      eventtype.name = Faker::Name.name
    end
  end
end