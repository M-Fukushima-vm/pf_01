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
end
