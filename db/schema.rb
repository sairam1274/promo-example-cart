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

ActiveRecord::Schema.define(version: 20140219144632) do

  create_table "cart_items", force: true do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.string   "product_type"
    t.integer  "qtd"
    t.integer  "single_value"
    t.integer  "full_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id"
  add_index "cart_items", ["product_id", "product_type"], name: "index_cart_items_on_product_id_and_product_type"

  create_table "carts", force: true do |t|
    t.integer  "cart_items_count"
    t.integer  "total_value"
    t.integer  "discount_value"
    t.integer  "final_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.string   "product_type"
    t.integer  "qtd"
    t.integer  "single_value"
    t.integer  "full_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"
  add_index "order_items", ["product_id", "product_type"], name: "index_order_items_on_product_id_and_product_type"

  create_table "orders", force: true do |t|
    t.integer  "order_items_count"
    t.integer  "total_value"
    t.integer  "discount_value"
    t.integer  "final_value"
    t.integer  "payment_method"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promo_histories", force: true do |t|
    t.integer  "cart_id"
    t.string   "cart_type"
    t.integer  "order_id"
    t.string   "order_type"
    t.integer  "promo_promocode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "promo_histories", ["cart_id", "cart_type"], name: "index_promo_histories_on_cart_id_and_cart_type"
  add_index "promo_histories", ["order_id", "order_type"], name: "index_promo_histories_on_order_id_and_order_type"
  add_index "promo_histories", ["promo_promocode_id"], name: "index_promo_histories_on_promo_promocode_id"

  create_table "promo_promocodes", force: true do |t|
    t.integer  "product_id"
    t.string   "product_type"
    t.integer  "cart_id"
    t.string   "cart_type"
    t.integer  "order_id"
    t.string   "order_type"
    t.integer  "value",        default: 0
    t.integer  "promo_type",               null: false
    t.integer  "status",       default: 1
    t.integer  "quantity",     default: 1
    t.integer  "used",         default: 0
    t.datetime "expires",                  null: false
    t.string   "code",                     null: false
    t.datetime "used_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "promo_promocodes", ["cart_id", "cart_type"], name: "index_promo_promocodes_on_cart_id_and_cart_type"
  add_index "promo_promocodes", ["order_id", "order_type"], name: "index_promo_promocodes_on_order_id_and_order_type"
  add_index "promo_promocodes", ["product_id", "product_type"], name: "index_promo_promocodes_on_product_id_and_product_type"

end
