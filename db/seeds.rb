# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者のメールアドレスとパスワードを事前に追加(URLは直接入力)
Admin.create!(email: 'admin@test.com', password: 'testtest',)

User.create!(name: 'tarou', email: 'a@a', password: 'testtest')
User.create!(name: 'jirou', email: 'b@b', password: 'testtest')
