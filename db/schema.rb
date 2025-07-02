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

ActiveRecord::Schema[8.0].define(version: 2025_07_02_111635) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "dosetimings", force: :cascade do |t|
    t.string "dose_time", null: false
    t.string "dose_timing", null: false
    t.time "reminder_time", null: false
    t.bigint "medicine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medicine_id"], name: "index_dosetimings_on_medicine_id"
  end

  create_table "familymembers", force: :cascade do |t|
    t.string "name", null: false
    t.string "relationship", null: false
    t.string "line_uid", null: false
    t.datetime "invited_at", null: false
    t.boolean "accepted", default: false, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_familymembers_on_user_id"
  end

  create_table "intakelogs", force: :cascade do |t|
    t.time "scheduled_at", null: false
    t.time "taken_at"
    t.integer "status", default: 0, null: false
    t.bigint "user_id"
    t.bigint "medicine_id"
    t.bigint "dosetiming_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dosetiming_id"], name: "index_intakelogs_on_dosetiming_id"
    t.index ["medicine_id"], name: "index_intakelogs_on_medicine_id"
    t.index ["user_id"], name: "index_intakelogs_on_user_id"
  end

  create_table "medicines", force: :cascade do |t|
    t.string "name", null: false
    t.integer "dose_per_day", null: false
    t.integer "pills_per_dose", null: false
    t.integer "stock_count", null: false
    t.integer "stock_alert_count", default: 0, null: false
    t.integer "stock_alert_month", default: 0, null: false
    t.string "medicine_image"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_medicines_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.integer "age", default: 0, null: false
    t.string "gender", default: "Not known", null: false
    t.string "email"
    t.integer "reminder_interval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "provider"
    t.string "uid"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "line_user_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "dosetimings", "medicines"
  add_foreign_key "familymembers", "users"
  add_foreign_key "intakelogs", "dosetimings"
  add_foreign_key "intakelogs", "medicines"
  add_foreign_key "intakelogs", "users"
  add_foreign_key "medicines", "users"
end
