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

ActiveRecord::Schema[8.0].define(version: 2025_01_08_183505) do
  create_table "lista", force: :cascade do |t|
    t.string "titulo"
    t.text "tasks", default: "[]"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "pasta_id", null: false
    t.index ["pasta_id"], name: "index_lista_on_pasta_id"
    t.index ["user_id"], name: "index_lista_on_user_id"
  end

  create_table "pasta", force: :cascade do |t|
    t.string "titulo"
    t.text "tasks", default: "[]"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_pasta_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "titulo"
    t.string "prioridade"
    t.string "status"
    t.integer "tempo_estimado"
    t.string "descrição"
    t.date "data_inicio"
    t.date "data_limite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lista_id", null: false
    t.index ["lista_id"], name: "index_tasks_on_lista_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
    t.string "password_digest"
    t.datetime "confirmed_at"
  end

  add_foreign_key "lista", "pasta", column: "pasta_id"
  add_foreign_key "lista", "users"
  add_foreign_key "pasta", "users"
  add_foreign_key "tasks", "lista", column: "lista_id"
end
