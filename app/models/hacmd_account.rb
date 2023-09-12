class HacmdAccount < ApplicationRecord
	has_encrypted :api_key

	# アソシエーションの定義
	belongs_to :user
	# バリデーションの定義
	validates :key_name, presence: true
	validates :api_key, presence: true
	validates :user_id, presence: true
end
