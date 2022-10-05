# -*- mode: ruby -*-
# vi: set ft=ruby :
create_table "active_storage_variant_records", force: :cascade do |t|
  t.integer "blob_id", null: false
  t.string "variation_digest", null: false
  t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
end
