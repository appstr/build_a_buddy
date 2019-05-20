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

ActiveRecord::Schema.define(version: 2019_05_20_140915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessories", force: :cascade do |t|
    t.integer "description"
    t.integer "size"
    t.integer "quantity"
    t.float "cost"
    t.float "sale_price"
    t.float "profit"
    t.string "product_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accessory_purchases", force: :cascade do |t|
    t.bigint "accessory_id"
    t.bigint "purchase_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accessory_id"], name: "index_accessory_purchases_on_accessory_id"
    t.index ["purchase_order_id"], name: "index_accessory_purchases_on_purchase_order_id"
  end

  create_table "compatibilities", force: :cascade do |t|
    t.bigint "stuffed_animal_id"
    t.bigint "accessory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accessory_id"], name: "index_compatibilities_on_accessory_id"
    t.index ["stuffed_animal_id"], name: "index_compatibilities_on_stuffed_animal_id"
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.datetime "purchase_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stuffed_animal_purchases", force: :cascade do |t|
    t.bigint "stuffed_animal_id"
    t.bigint "purchase_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchase_order_id"], name: "index_stuffed_animal_purchases_on_purchase_order_id"
    t.index ["stuffed_animal_id"], name: "index_stuffed_animal_purchases_on_stuffed_animal_id"
  end

  create_table "stuffed_animals", force: :cascade do |t|
    t.integer "description"
    t.integer "quantity"
    t.float "cost"
    t.float "sale_price"
    t.float "profit"
    t.string "product_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
