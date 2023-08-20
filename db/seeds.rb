# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  name: "test user",
  email: "test@email.com",
  password: "password", 
  password_confirmation: "password", 
  avatar_name: "T.U",
  introduction: "テスト用ユーザー"
)

User.create(
  name: "guest user",
  email: "guest@email.com",
  password: "password", 
  password_confirmation: "password", 
  avatar_name: "G.U",
  introduction: "ゲストユーザー"
)

User.create(
  name: "test user1",
  email: "test-1@email.com",
  password: "password", 
  password_confirmation: "password", 
  avatar_name: "T.1",
  introduction: "テストユーザー1"
)

User.create(
  name: "test user2",
  email: "test-2@email.com",
  password: "password", 
  password_confirmation: "password", 
  avatar_name: "T.2",
  introduction: "テストユーザー2"
)

30.times do |n|
  name  = Gimei.unique.name.romaji
  email = "example-#{n+1}@email.com"
  password = "password"
  avatar_name = name.split.map { |s| s[0]}.join('.').upcase
  User.create!(
    name: name,
    email: email,
    password:              password,
    password_confirmation: password,
    avatar_name: avatar_name,
  )
end

# フォローイング
tester = User.first
guest = User.find(2)
samples = User.where(id: [3..4]).order(id: :asc)
dammies1 = User.where(id: [5..31]).order(id: :asc)
dammies2 = User.where(id: [5..34]).order(id: :asc)
  # テストユーザー関係
    # テストユーザーがフォロー
      samples.each { |sample| tester.active_relationships.create(followed_id: sample.id) }
      dammies1.each { |dammy| tester.active_relationships.create(followed_id: dammy.id) }
    # テストユーザーをフォロー
      samples.each { |sample| sample.active_relationships.create(followed_id: tester.id) }
      dammies2.each { |dammy| dammy.active_relationships.create(followed_id: tester.id) }
		# テストユーザーのフォロー歴作成
			samples.each { |sample| tester.active_looked_users.create(seen_follower_id: sample.id) }
			dammies1.each { |dammy| tester.active_looked_users.create(seen_follower_id: dammy.id) }

  # ゲストユーザー関係
    # ゲストユーザーがフォロー
      guest.active_relationships.create(followed_id: 4)
    # ゲストユーザーをフォロー
      samples.each { |sample| sample.active_relationships.create(followed_id: guest.id) }
		# ゲストユーザーのフォロー歴作成
			guest.active_looked_users.create(seen_follower_id: 4)

	# ダミーユーザー関係
		# ダミーユーザー同士の相互フォロー
			dammies2.to_a.permutation(2) do |user1, user2|
				user1.active_relationships.create(followed_id: user2.id)
			end
		# ダミーユーザー同士のフォロー歴作成
			dammies2.to_a.permutation(2) do |user1, user2|
				user1.active_looked_users.create(seen_follower_id: user2.id)
			end

