# -*- mode: ruby -*-
# vi: set ft=ruby :
create_table "mute_users", force: :cascade do |t|
  t.integer "mute_user_id", null: false
  t.integer "muted_id", null: false
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.index ["mute_user_id"], name: "index_mute_users_on_muted_id"
  t.index ["mute_user_id", "muted_id"], name: "index_mute_users_on_mute_user_id_and_muted_id", unique: true
  t.index ["mute_user_id"], name: "index_mute_users_on_mute_user_id"
end