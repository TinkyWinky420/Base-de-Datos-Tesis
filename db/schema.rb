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

ActiveRecord::Schema[8.1].define(version: 2026_07_24_145553) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "asesores", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "nombre"
    t.integer "tesis_id"
    t.datetime "updated_at", null: false
  end

  create_table "carreras", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "nombre"
    t.datetime "updated_at", null: false
  end

  create_table "historials", force: :cascade do |t|
    t.string "accion"
    t.datetime "created_at", null: false
    t.text "descripcion"
    t.datetime "updated_at", null: false
  end

  create_table "integrantes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "matricula"
    t.string "nombre"
    t.integer "tesis_id"
    t.datetime "updated_at", null: false
  end

  create_table "nombres", force: :cascade do |t|
    t.string "carrera"
    t.datetime "created_at", null: false
    t.text "descripcion"
    t.string "numero_control"
    t.string "plantel"
    t.string "titulo"
    t.datetime "updated_at", null: false
    t.string "zona"
  end

  create_table "plantel_carreras", force: :cascade do |t|
    t.integer "carrera_id", null: false
    t.datetime "created_at", null: false
    t.integer "plantel_id", null: false
    t.datetime "updated_at", null: false
    t.index ["carrera_id"], name: "index_plantel_carreras_on_carrera_id"
    t.index ["plantel_id"], name: "index_plantel_carreras_on_plantel_id"
  end

  create_table "plantels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "nombre"
    t.datetime "updated_at", null: false
    t.integer "zona_id", null: false
    t.index ["zona_id"], name: "index_plantels_on_zona_id"
  end

  create_table "zonas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "nombre"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "plantel_carreras", "carreras"
  add_foreign_key "plantel_carreras", "plantels"
  add_foreign_key "plantels", "zonas"
end
