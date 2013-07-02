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

ActiveRecord::Schema.define(:version => 20130701152613) do

  create_table "contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "contacts", ["email"], :name => "index_contacts_on_email"
  add_index "contacts", ["first_name"], :name => "index_contacts_on_first_name"
  add_index "contacts", ["last_name"], :name => "index_contacts_on_last_name"
  add_index "contacts", ["phone"], :name => "index_contacts_on_phone"

  create_table "contacts_organizations", :id => false, :force => true do |t|
    t.integer "contact_id"
    t.integer "organization_id"
  end

  create_table "facets", :force => true do |t|
    t.string   "name",                                         :null => false
    t.string   "context",    :limit => 128,                    :null => false
    t.integer  "position",                  :default => 1
    t.boolean  "primary",                   :default => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "organizations", ["location"], :name => "index_organizations_on_location"
  add_index "organizations", ["name"], :name => "index_organizations_on_name"
  add_index "organizations", ["phone"], :name => "index_organizations_on_phone"

  create_table "projects", :force => true do |t|
    t.string   "title",                             :null => false
    t.string   "description",       :limit => 5120
    t.string   "repository_url",    :limit => 1024
    t.string   "app_url",           :limit => 1024
    t.string   "micropost_url",     :limit => 1024
    t.string   "news_url",          :limit => 1024
    t.string   "documentation_url", :limit => 1024
    t.date     "launch_date"
    t.date     "conception_date"
    t.integer  "contact_id"
    t.integer  "organization_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :null => false
    t.string   "encrypted_password",                    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
