# -*- mode: ruby -*-
# vi: set ft=ruby :
create_table "users", force: :cascade do |t|
  t.string "name", null: false
  t.string "email", null: false
  t.string "password_digest", null: false
  t.string "avatar_name"
  t.text "introduction"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.index ["email"], name: "index_users_on_email", unique: true
end

add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
