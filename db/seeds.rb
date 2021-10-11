# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

HAND_MASTERS = [
  { name: 'ストレート・フラッシュ', strength: 80 },
  { name: 'フォーカード', strength: 70 },
  { name: 'フルハウス', strength: 60 },
  { name: 'フラッシュ', strength: 50 },
  { name: 'ストレート', strength: 40 },
  { name: 'スリーカード', strength: 30 },
  { name: 'ツーペア', strength: 20 },
  { name: 'ワンペア', strength: 10 },
  { name: 'ノーハンド', strength: 0 }
]

HAND_MASTERS.each do |hand_master|
  HandMaster.create(
    hand_name: hand_master[:name],
    strength: hand_master[:strength]
  )
end
