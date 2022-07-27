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

