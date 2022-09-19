class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 4 }, allow_nil: true # 空パスワードのアップデートを許容
  validates :avatar_name, length: {maximum: 3}

  has_one_base64_attached :avatar # 1つの画像データ添付を設定する場合
  # has_many_base64_attached :avatar # 複数の画像データ添付を設定する場合

  # 検索したい文字列が含まれているレコードを返す
  scope :by_name, ->(name) { where('name LIKE ?', "%#{name}%") }

  # (自分が)フォローしているユーザー
  has_many :active_relationships, class_name: "Relationship", # 特定用
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed # 取得用

  # (自分を)フォローしているユーザー
  has_many :passive_relationships, class_name:  "Relationship", # 特定用
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower # 取得用

  # 友達（互いにフォローしている）をデータベースから取得
  def matchers
    # 重複を配列で返す "&"メソッド で
    # has_many の followings・followers の重複を返す => 使用例： current_user.matchers
    followings & followers
  end

end
