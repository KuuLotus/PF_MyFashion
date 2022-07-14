# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tag.create([
  { name: '古着' },
  { name: 'デニム' },
  { name: 'フレアパンツ' },
  { name: 'バケットハット' },
  { name: 'ショートパンツ' },
  { name: 'モード' },
  { name: 'ハンチング' },
  { name: 'プチプラコーデ' },
  { name: 'サンダル' },
  { name: 'ストリート' }
])

Admin.create!(
  email: 'admin@admin',
  password: 'adminadmin',
  )

Member.create!(
  name: "成田凌",
  email: 'narita@gmail.com',
  password: 'narita',
  )
Member.create!(
  name: "綾野剛",
  email: 'ayano@gmail.com',
  password: '555555',
  )
Member.create!(
  name: "小松菜奈",
  email: 'komatu@gmail.com',
  password: '777777',
  )
Member.create!(
  name: "ロバート馬場",
  email: 'baba@gmail.com',
  password: 'bababa',
  )

