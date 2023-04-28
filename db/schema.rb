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

ActiveRecord::Schema.define(version: 2021_06_11_143322) do

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "value"
    t.integer "portionSize"
    t.integer "quantity", default: 0
    t.integer "restaurant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.index ["restaurant_id"], name: "index_dishes_on_restaurant_id"
  end

  create_table "order_dishes", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "dish_id", null: false
    t.integer "quantity", default: 0
    t.float "partial_value", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dish_id"], name: "index_order_dishes_on_dish_id"
    t.index ["order_id"], name: "index_order_dishes_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.boolean "is_done"
    t.boolean "is_confirmed"
    t.integer "grade"
    t.integer "rating"
    t.integer "client_id"
    t.integer "deliveryman_id"
    t.integer "restaurant_id"
    t.float "total_value", default: 10.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["deliveryman_id"], name: "index_orders_on_deliveryman_id"
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "foodType"
    t.string "openingHour"
    t.string "address"
    t.string "cnpj"
    t.float "rating"
    t.integer "most_selled"
    t.integer "total_sales"
    t.integer "total_loyal_costumers"
    t.integer "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.index ["owner_id"], name: "index_restaurants_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "birthdate"
    t.string "phone"
    t.string "password_digest"
    t.string "cpf"
    t.string "address"
    t.integer "role", default: 0
    t.boolean "is_valid", default: false
    t.string "validate_token"
    t.datetime "validate_token_expiry_at"
    t.float "funds"
    t.string "cnh"
    t.string "vehicle"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "dishes", "restaurants"
  add_foreign_key "order_dishes", "dishes"
  add_foreign_key "order_dishes", "orders"
  add_foreign_key "orders", "restaurants"
  add_foreign_key "orders", "users", column: "client_id"
  add_foreign_key "orders", "users", column: "deliveryman_id"
  add_foreign_key "restaurants", "users", column: "owner_id"
end
