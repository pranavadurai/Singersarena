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

ActiveRecord::Schema.define(version: 20170107104100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.boolean  "is_admin",       default: false
    t.string   "remember_token"
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.text     "comment"
    t.integer  "likes",      default: [],                array: true
    t.boolean  "visible",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title"
    t.string   "category"
    t.string   "language"
    t.string   "song"
    t.integer  "user_id"
    t.integer  "likes",      default: [],                array: true
    t.integer  "fav",        default: [],                array: true
    t.boolean  "visible",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "song_type"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.bigint   "phone"
    t.string   "gender"
    t.string   "city"
    t.string   "country"
    t.binary   "pic"
    t.string   "pictype"
    t.string   "dpic"
    t.text     "aboutme"
    t.boolean  "msga"
    t.boolean  "viemail"
    t.boolean  "viphone"
    t.boolean  "is_singer"
    t.json     "tag_hear"
    t.json     "tag_sing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
