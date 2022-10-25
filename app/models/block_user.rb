class BlockUser < ApplicationRecord
  # アソシエーションの定義
  belongs_to :block_user, class_name: "User" # ブロックしたユーザー
  belongs_to :blocked, class_name: "User" # ブロックされたユーザー

  # バリデーションの定義
  validates :block_user_id, presence: true
  validates :blocked_id, presence: true
  # block_user_idとblocked_idの組み合わせが一意になるようバリデーション
  validates :block_user_id, uniqueness: { scope: :blocked_id }
end
