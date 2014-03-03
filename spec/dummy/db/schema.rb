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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131004085907) do

  create_table "pictures", force: true do |t|
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_usertag_usertaggings", force: true do |t|
    t.integer "usertag_id"
    t.integer "usertaggable_id"
    t.string  "usertaggable_type"
  end

  add_index "simple_usertag_usertaggings", ["usertag_id"], name: "index_simple_usertag_usertaggings_on_usertag_id"
  add_index "simple_usertag_usertaggings", ["usertaggable_id", "usertaggable_type"], name: "index_usertaggings_usertaggable_id_usertaggable_type"

  create_table "simple_usertag_usertags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
