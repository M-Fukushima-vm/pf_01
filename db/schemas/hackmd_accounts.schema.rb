# encoding: utf-8 << 最上段に追記で日本語対応
# -*- mode: ruby -*-
# vi: set ft=ruby :
create_table "hackmd_accounts", force: :cascade do |t|
  t.string "key_name", null: false
	t.string "api_key", null: false
	t.integer "user_id", null: false
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
	t.index ["user_id"], name: "index_hackmd_accounts_on_user_id" # user_id に index
	t.index ["api_key"], name: "index_hackmd_accounts_on_api_key" # api_key に index
	t.index ["user_id", "api_key"], name: "index_hackmd_accounts_on_user_id_and_api_key", unique: true # user_id と api_key の組み合わせが一意
end
