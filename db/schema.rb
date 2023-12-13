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

ActiveRecord::Schema[7.0].define(version: 2023_11_29_061333) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "article_sells", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "sell_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.decimal "revenue", default: "0.0"
    t.bigint "insurance_policy_id"
    t.integer "insured_articles"
    t.decimal "special_price"
    t.index ["article_id"], name: "index_article_sells_on_article_id"
    t.index ["insurance_policy_id"], name: "index_article_sells_on_insurance_policy_id"
    t.index ["sell_id"], name: "index_article_sells_on_sell_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "default_prices", force: :cascade do |t|
    t.integer "category"
    t.integer "width"
    t.integer "length"
    t.integer "height"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "departure_dates", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "destinataries", force: :cascade do |t|
    t.string "full_name"
    t.string "street"
    t.string "ext_number"
    t.string "int_number"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "primary_phone_number"
    t.string "secondary_phone_number"
    t.bigint "remitent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "estafeta_office_address"
    t.integer "delivery_place"
    t.index ["remitent_id"], name: "index_destinataries_on_remitent_id"
  end

  create_table "insurance_policies", force: :cascade do |t|
    t.integer "percentage"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "remitents", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_code"
  end

  create_table "sells", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "tracking_guide"
    t.string "phone_code"
    t.bigint "departure_date_id"
    t.bigint "remitent_id"
    t.bigint "destinatary_id"
    t.integer "shipment_number", default: 0
    t.string "carrier_name"
    t.index ["departure_date_id"], name: "index_sells_on_departure_date_id"
    t.index ["destinatary_id"], name: "index_sells_on_destinatary_id"
    t.index ["remitent_id"], name: "index_sells_on_remitent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "token_id"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recover_password_token"
    t.integer "role", default: 0
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "article_sells", "articles"
  add_foreign_key "article_sells", "insurance_policies"
  add_foreign_key "article_sells", "sells"
  add_foreign_key "destinataries", "remitents"
  add_foreign_key "profiles", "users"
  add_foreign_key "sells", "departure_dates"
  add_foreign_key "sells", "destinataries"
  add_foreign_key "sells", "remitents"
end
