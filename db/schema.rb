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

ActiveRecord::Schema[8.0].define(version: 2025_02_07_120344) do
  create_table "accounts", force: :cascade do |t|
    t.string "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "supplier_id", null: false
    t.string "password"
    t.string "password_confirmation"
    t.index ["supplier_id"], name: "index_accounts_on_supplier_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.integer "library_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["library_id"], name: "index_books_on_library_id"
  end

  create_table "coffees", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.string "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
  end

  create_table "computers", force: :cascade do |t|
    t.string "market"
    t.string "device_type"
    t.string "mouse"
    t.string "trackpad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holidays", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "payment_type"
    t.string "card_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.boolean "terms_of_service"
    t.string "surname"
    t.integer "age"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "points"
    t.integer "games_played"
    t.integer "age"
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "salary"
    t.float "win_percentage"
    t.integer "losses"
    t.integer "draws"
    t.integer "experience"
  end

  create_table "promotions", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "legacy_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.text "bio"
    t.string "password"
    t.string "registration_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin"
    t.string "login"
    t.string "username"
    t.string "status"
    t.string "email"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "voters", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accounts", "suppliers"
  add_foreign_key "books", "libraries"
end
