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

ActiveRecord::Schema.define(version: 2019_09_02_024138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "congregations", force: :cascade do |t|
    t.string "name"
    t.boolean "home"
    t.string "coordinator"
    t.string "coordinator_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outlines", force: :cascade do |t|
    t.integer "number"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "speaker_outlines", force: :cascade do |t|
    t.bigint "speaker_id"
    t.bigint "outline_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["outline_id"], name: "index_speaker_outlines_on_outline_id"
    t.index ["speaker_id"], name: "index_speaker_outlines_on_speaker_id"
  end

  create_table "speakers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.integer "congregation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "talks", force: :cascade do |t|
    t.date "date"
    t.bigint "speaker_id"
    t.bigint "outline_id"
    t.integer "congregation_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "assembly"
    t.index ["outline_id"], name: "index_talks_on_outline_id"
    t.index ["speaker_id"], name: "index_talks_on_speaker_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.date "password_reset_sent_at"
    t.string "password_reset_token"
    t.string "secure_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "speaker_outlines", "outlines"
  add_foreign_key "speaker_outlines", "speakers"
  add_foreign_key "talks", "outlines"
  add_foreign_key "talks", "speakers"
end
