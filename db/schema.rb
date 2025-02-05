# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_05_103227) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "academies", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "phone", limit: 20
    t.text "address"
    t.string "email", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_application_statuses", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_default", default: false
    t.index ["name"], name: "index_event_application_statuses_on_name", unique: true
  end

  create_table "event_applications", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "warrior_id", null: false
    t.boolean "gi"
    t.boolean "nogi"
    t.boolean "mma"
    t.decimal "weight"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_application_status_id", null: false
    t.index ["event_application_status_id"], name: "index_event_applications_on_event_application_status_id"
    t.index ["event_id"], name: "index_event_applications_on_event_id"
    t.index ["warrior_id"], name: "index_event_applications_on_warrior_id"
  end

  create_table "event_statuses", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_event_statuses_on_name", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "name", limit: 100
    t.date "date"
    t.string "location", limit: 100
    t.date "registration_deadline"
    t.text "description"
    t.boolean "gi"
    t.boolean "nogi"
    t.boolean "mma"
    t.bigint "event_status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_status_id"], name: "index_events_on_event_status_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 100
    t.string "password_digest", limit: 255
    t.string "first_name", limit: 50
    t.string "last_name", limit: 50
    t.integer "role"
    t.string "phone", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "warriors", force: :cascade do |t|
    t.string "first_name", limit: 50
    t.string "last_name", limit: 50
    t.date "date_of_birth"
    t.decimal "weight"
    t.string "belt_rank", limit: 20
    t.integer "experience_years"
    t.boolean "gi_practitioner"
    t.boolean "nogi_practitioner"
    t.string "phone", limit: 20
    t.bigint "user_id", null: false
    t.bigint "academy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academy_id"], name: "index_warriors_on_academy_id"
    t.index ["user_id"], name: "index_warriors_on_user_id"
  end

  add_foreign_key "event_applications", "event_application_statuses"
  add_foreign_key "event_applications", "events"
  add_foreign_key "event_applications", "warriors"
  add_foreign_key "events", "event_statuses"
  add_foreign_key "warriors", "academies"
  add_foreign_key "warriors", "users"
end
