class MuteUser < ApplicationRecord
  # アソシエーションの定義
  belongs_to :mute_user, class_name: "User" # ミュートしたユーザー
  belongs_to :muted, class_name: "User" # ミュートされたユーザー

  # バリデーションの定義
  validates :mute_user_id, presence: true
  validates :muted_id, presence: true
  # mute_user_idとmuted_idの組み合わせが一意になるようバリデーション
  validates :mute_user_id, uniqueness: { scope: :muted_id }
end
