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

ActiveRecord::Schema.define(version: 20140111064120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contestants", force: true do |t|
    t.text    "first_name"
    t.text    "last_name"
    t.integer "season_id"
    t.boolean "eliminated"
  end

  create_table "eligible_contestants", force: true do |t|
    t.integer "contestant_id"
    t.integer "week_id"
  end

  create_table "picks", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "week_id"
    t.integer  "order"
    t.integer  "contestant_id"
    t.boolean  "rose"
  end

  create_table "seasons", force: true do |t|
    t.text    "name"
    t.boolean "current"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
    t.text     "provider"
    t.text     "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weekly_results", force: true do |t|
    t.integer "week_id"
    t.integer "order"
    t.integer "contestant_id"
    t.boolean "rose"
  end

  create_table "weeks", force: true do |t|
    t.text    "name"
    t.integer "season_id"
    t.boolean "locked",    default: true
  end

end
