class Relationship < ApplicationRecord
  # アソシエーションの定義
  belongs_to :follower, class_name: "User"  # フォローしたユーザー
  belongs_to :followed, class_name: "User"  # フォローされたユーザー

  # バリデーションの定義
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  # follower_idとfollowed_idの組み合わせが一意になるようバリデーション
  validates :follower_id, uniqueness: { scope: :followed_id }
end
