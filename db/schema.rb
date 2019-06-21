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

ActiveRecord::Schema.define(version: 20181119051133) do

  create_table "content_engine_filetags", force: :cascade do |t|
    t.string "filename"
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_engine_images", force: :cascade do |t|
    t.string "code"
    t.string "filename"
    t.string "extension"
    t.binary "imagefile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inspector_engine_confirms", force: :cascade do |t|
    t.string "houhou"
    t.string "houhou_eng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inspector_engine_criterions", force: :cascade do |t|
    t.string "item_type"
    t.string "kijun"
    t.string "houhou"
    t.string "kijun_eng"
    t.string "houhou_eng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inspector_engine_inspections", force: :cascade do |t|
    t.string "code"
    t.string "houhou"
    t.string "houhou_eng"
    t.string "basho"
    t.string "basho_eng"
    t.string "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inspector_engine_judges", force: :cascade do |t|
    t.string "houhou"
    t.string "houhou_eng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inspector_engine_needles", force: :cascade do |t|
    t.string "houhou"
    t.string "houhou_eng"
    t.string "basho"
    t.string "basho_eng"
    t.string "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inspector_engine_packages", force: :cascade do |t|
    t.string "package"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.text "catchcopy"
    t.integer "weight_g"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "maker_code"
    t.string "genre_code"
    t.string "change_note"
    t.string "sch_release_date"
    t.string "size"
    t.string "package_size"
    t.decimal "package_weight"
    t.text "size_note"
    t.string "battery"
    t.text "catchcopy_main"
    t.text "catchcopy_long"
    t.text "catchcopy_sub1"
    t.text "catchcopy_sub2"
    t.text "catchcopy_sub3"
    t.text "discription"
    t.text "usage"
    t.text "care"
    t.text "detailed_description"
    t.text "caution"
    t.string "description_path1"
    t.string "description_path2"
    t.string "target_age"
    t.string "accessories"
    t.string "manufacture"
    t.string "material"
    t.string "country_origin"
    t.integer "inner_carton"
    t.decimal "outer_carton"
    t.string "outer_size"
    t.decimal "outer_weight"
    t.boolean "cataloged"
    t.text "catalog_copy"
    t.string "kana"
    t.index ["code"], name: "index_products_on_code", unique: true
  end

  create_table "return_engine_deliverytraders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "return_engine_inputpeople", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "return_engine_returnbooks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "return_engine_returnlogs", force: :cascade do |t|
    t.string "arrived_date"
    t.string "delivery_trader"
    t.string "owner_code"
    t.string "owner_name"
    t.string "cutoff_date"
    t.string "sales_person"
    t.string "inquiry_no"
    t.string "boxes_count"
    t.string "peace_count"
    t.string "returned_date"
    t.string "input_person"
    t.string "note"
    t.string "return_book"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "return_engine_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
