# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 19) do

  create_table "addresses", :force => true do |t|
    t.string  "address_1"
    t.string  "address_2"
    t.string  "city"
    t.string  "state"
    t.string  "postal_code"
    t.string  "country"
    t.string  "phone_number"
    t.string  "fax_number"
    t.string  "email"
    t.string  "website"
    t.string  "addressable_type"
    t.integer "addressable_id"
  end

  create_table "entries", :force => true do |t|
    t.integer  "section_id"
    t.integer  "position"
    t.datetime "last_searched_at"
    t.text     "details"
    t.string   "name"
    t.string   "title"
    t.string   "organization"
    t.string   "department"
    t.integer  "address_id"
    t.string   "location"
    t.string   "start_date"
    t.string   "end_date"
    t.string   "gpa"
    t.string   "specialization"
    t.string   "qualification"
    t.string   "full_name"
  end

  create_table "resume_options", :force => true do |t|
    t.integer "resume_id"
    t.boolean "address_1",    :default => false, :null => false
    t.boolean "address_2",    :default => false, :null => false
    t.boolean "city",         :default => true,  :null => false
    t.boolean "state",        :default => true,  :null => false
    t.boolean "postal_code",  :default => true,  :null => false
    t.boolean "country",      :default => true,  :null => false
    t.boolean "phone_number", :default => false, :null => false
    t.boolean "fax_number",   :default => false, :null => false
    t.boolean "email",        :default => false, :null => false
    t.boolean "website",      :default => false, :null => false
  end

  create_table "resume_styles", :force => true do |t|
    t.string "name"
  end

  create_table "resumes", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "resume_style_id",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",              :default => true, :null => false
    t.datetime "report_generated_at"
  end

  create_table "section_types", :force => true do |t|
    t.string "name"
  end

  create_table "sections", :force => true do |t|
    t.string  "type"
    t.string  "name"
    t.integer "resume_id"
    t.integer "position"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_login"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                   :default => "passive"
    t.datetime "deleted_at"
    t.string   "password_reset_code",       :limit => 40
    t.boolean  "is_admin",                                :default => false
    t.string   "time_zone"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
  end

end
