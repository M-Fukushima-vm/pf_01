class HackmdArchive < ApplicationRecord

	# アソシエーションの定義
	belongs_to :user

	# バリデーションの定義
	validates :title, presence: true
	validates :link, presence: true
	validates :short_id, presence: true, uniqueness: true
	validates :user_id, presence: true

	# 検索したい文字列が含まれているレコードを返す
  scope :by_title, ->(title) { where('title LIKE ?', "%#{title}%") }

end
