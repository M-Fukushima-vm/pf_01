class Memo < ApplicationRecord
	# アソシエーションの定義
	belongs_to :user
	# バリデーションの定義
	validates :memo_title, presence: true
	validates :user_id, presence: true
end
