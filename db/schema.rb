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

ActiveRecord::Schema.define(version: 2021_03_25_101634) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "diseases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "facilities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "kind"
    t.string "name"
    t.string "state"
    t.string "district"
    t.uuid "lsg_body"
    t.uuid "ward"
    t.string "address"
    t.bigint "pincode"
    t.bigint "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "parent_id"
    t.index ["parent_id"], name: "index_facilities_on_parent_id"
  end

  create_table "family_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "patient_id"
    t.string "full_name"
    t.string "phone"
    t.date "dob"
    t.string "relation"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "education"
    t.string "occupation"
    t.string "remarks"
  end

  create_table "lsg_bodies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
    t.string "district"
  end

  create_table "patients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "full_name"
    t.date "dob"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "address"
    t.string "route"
    t.string "phone"
    t.string "economic_status"
    t.string "notes"
    t.uuid "asha_member"
    t.uuid "reported_by"
    t.uuid "created_by"
    t.uuid "lsg_body"
    t.uuid "facility_id"
    t.string "sex"
    t.string "emergency_phone_no"
    t.string "disease"
    t.string "patient_views"
    t.string "family_views"
    t.index ["facility_id"], name: "index_patients_on_facility_id"
  end

  create_table "patients_users", force: :cascade do |t|
    t.uuid "patient_id"
    t.uuid "user_id"
  end

  create_table "students", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "full_name"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.bigint "phone"
    t.string "password_digest"
    t.boolean "verified", default: true
    t.uuid "facility_id"
    t.string "otp_secret_key"
    t.index ["email", "phone"], name: "index_users_on_email_and_phone", unique: true
    t.index ["facility_id"], name: "index_users_on_facility_id"
  end

  create_table "visits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "first_visit"
    t.datetime "last_visit"
    t.json "records"
    t.datetime "next_visit"
    t.uuid "patient_id"
    t.uuid "user_id"
  end

  create_table "wards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.bigint "number"
    t.uuid "lsg_body_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lsg_body_id"], name: "index_wards_on_lsg_body_id"
  end

  add_foreign_key "facilities", "facilities", column: "parent_id"
  add_foreign_key "wards", "lsg_bodies"
end
