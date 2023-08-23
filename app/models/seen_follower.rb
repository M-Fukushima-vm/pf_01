class SeenFollower < ApplicationRecord
  # アソシエーションの定義
  belongs_to :seen_follower, class_name: "User" # (持たれる複数側: x)見られたフォロワー
  belongs_to :looked_user, class_name: "User" # (持つ側: 1)見てたユーザー

  # バリデーションの定義
  validates :seen_follower_id, presence: true # x のプロパティ(カラム)
  validates :looked_user_id, presence: true # 1 のプロパティ(カラム)
  # seen_follower_idとlooked_user_idの組み合わせが一意になるようバリデーション
  validates :seen_follower_id, uniqueness: { scope: :looked_user_id }
end
