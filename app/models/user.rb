class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 4 }, allow_nil: true # 空パスワードのアップデートを許容
  validates :avatar_name, length: {maximum: 3}

  has_one_base64_attached :avatar#, strict_loading: true # 1つの画像データ添付を設定する場合
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
  def mates
    # 重複を配列で返す "&"メソッド で
    # has_many の followings・followers の重複を返す => 使用例： current_user.matchers
    followings & followers
  end

  # (自分が)ミュートしているユーザー
  has_many :active_mute_users, class_name: "MuteUser",	# 特定用
                                foreign_key: "mute_user_id",
                                dependent: :destroy
  has_many :muting_users, through: :active_mute_users, source: :muted	# 取得用

  # チェイン元(自分含む) をミュートしているユーザー
	has_many :passive_mute_users, class_name:  "MuteUser",	# 特定用
                                foreign_key: "muted_id",
                                dependent: :destroy
  has_many :muting_left_users, through: :passive_mute_users, source: :mute_user	# 取得用

  # (自分が)ブロックしているユーザー
  has_many :active_block_users, class_name: "BlockUser",	# 特定用
                                foreign_key: "block_user_id",
                                dependent: :destroy
  has_many :blocking_users, through: :active_block_users, source: :blocked	# 取得用

  # チェイン元(自分含む) をブロックしているユーザー
	has_many :passive_block_users, class_name: "BlockUser",	# 特定用
                                  foreign_key: "blocked_id",
                                  dependent: :destroy
  has_many :blocking_left_users, through: :passive_block_users, source: :block_user	# 取得用

  # (自分が) 見たフォロワー
  has_many :active_looked_users, class_name: "SeenFollower", # 特定用
                                  foreign_key: "looked_user_id",
                                  dependent: :destroy
  has_many :seen_followers, through: :active_looked_users, # 取得用
                            source: :seen_follower

  # チェイン元(自分含む 左)を 見てたユーザー
  has_many :passive_seen_followers, class_name: "SeenFollower", # 特定用
                                  foreign_key: "seen_follower_id",
                                  dependent: :destroy
  has_many :looked_left_users, through: :passive_seen_followers, # 取得用
                                source: :looked_user

	has_many :memos, dependent: :destroy

	has_one :hackmd_account, dependent: :destroy

	has_many :hackmd_archives, dependent: :destroy

	has_many :hackmd_notes, dependent: :destroy
end
