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

ActiveRecord::Schema.define(version: 2021_03_08_084430) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "owners", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "available_day", default: "", null: false
    t.string "hour_start", default: "", null: false
    t.string "hour_end", default: "", null: false
    t.string "jti", null: false
    t.string "phone", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_owners_on_jti", unique: true
    t.index ["phone"], name: "index_owners_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "properties", force: :cascade do |t|
    t.bigint "owner_id", null: false
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.string "status", default: "", null: false
    t.decimal "rental_price", precision: 11, scale: 2, default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_properties_on_owner_id"
  end

  add_foreign_key "properties", "owners"
end
