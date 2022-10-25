# -*- mode: ruby -*-
# vi: set ft=ruby :
create_table "block_users", force: :cascade do |t|
  t.integer "block_user_id", null: false
  t.integer "blocked_id", null: false
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.index ["block_user_id"], name: "index_block_users_on_blocked_id"
  t.index ["block_user_id", "blocked_id"], name: "index_block_users_on_block_user_id_and_blocked_id", unique: true
  t.index ["block_user_id"], name: "index_block_users_on_block_user_id"
end