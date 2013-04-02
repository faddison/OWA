# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130402102211) do

  create_table "Eventlogs", :force => true do |t|
    t.integer  "event_id"
    t.integer  "visitor_id"
    t.string   "ename"
    t.string   "vname"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "date"
  end

  add_index "Eventlogs", ["event_id"], :name => "index_eventlogs_on_event_id"
  add_index "Eventlogs", ["visitor_id"], :name => "index_eventlogs_on_visitor_id"

  create_table "Events", :force => true do |t|
    t.string   "name"
    t.integer  "program_id"
    t.integer  "eventtype_id"
    t.integer  "facility_id"
    t.integer  "duration"
    t.string   "status"
    t.date     "date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "pname"
    t.string   "fname"
    t.string   "etname"
  end

  add_index "Events", ["eventtype_id"], :name => "index_events_on_eventtype_id"
  add_index "Events", ["facility_id"], :name => "index_events_on_facility_id"
  add_index "Events", ["program_id"], :name => "index_events_on_program_id"

  create_table "Visitors", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "language"
    t.string   "email"
    t.string   "phone"
    t.string   "name"
    t.string   "country"
    t.string   "postcode"
    t.string   "husband"
    t.string   "notes"
    t.date     "ftime"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "abbreviations", :force => true do |t|
    t.string   "word"
    t.string   "abbv"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "brochurelogs", :force => true do |t|
    t.date     "date"
    t.integer  "count"
    t.integer  "facility_id"
    t.integer  "brochure_id"
    t.string   "bname"
    t.string   "fname"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "brochurelogs", ["brochure_id"], :name => "index_brochurelogs_on_brochure_id"
  add_index "brochurelogs", ["date", "facility_id", "brochure_id"], :name => "index_brochurelogs_on_date_and_facility_id_and_brochure_id", :unique => true
  add_index "brochurelogs", ["facility_id"], :name => "index_brochurelogs_on_facility_id"

  create_table "brochures", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "children", :force => true do |t|
    t.string   "name"
    t.integer  "visitor_id"
    t.string   "allergies"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "children", ["visitor_id"], :name => "index_children_on_visitor_id"

  create_table "econtacts", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "relationship"
    t.integer  "visitor_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "econtacts", ["visitor_id"], :name => "index_econtacts_on_visitor_id"

  create_table "eventtypes", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "facilities", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fielddisplays", :force => true do |t|
    t.string   "model"
    t.string   "field"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "languages", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "referrallogs", :force => true do |t|
    t.date     "date"
    t.integer  "count"
    t.integer  "referral_id"
    t.integer  "facility_id"
    t.string   "fname"
    t.string   "rname"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "referrallogs", ["facility_id"], :name => "index_referrallogs_on_facility_id"
  add_index "referrallogs", ["referral_id"], :name => "index_referrallogs_on_referral_id"

  create_table "referrals", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "role_id"
    t.integer  "db_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
