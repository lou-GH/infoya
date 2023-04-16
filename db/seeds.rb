# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
 email: 'admin@example.com',
 password: 'adminpassword'
)

User.create!(
  [
    {email: 'shibainu@example.com', account_name: 'Shiba', password: 'password', prefecture: '東京都', introduction: 'フルーツが好きです！' , user_icon: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {email: 'kapibara@example.com', account_name: 'Kapibara', password: 'password', prefecture: '京都', introduction: '野菜を求めていろんな場所に行ってます。' , user_icon: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
    {email: 'harinezumi@example.com', account_name: 'Harinezumi', password: 'password', prefecture: '福岡県', introduction: '地元の食材で料理してます。' , user_icon: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")},
    {email: 'koneko@example.com', account_name: 'koneko', password: 'password', prefecture: '北海道', introduction: 'まだ寒いですね。' , user_icon: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.jpg"), filename:"sample-user4.jpg")},
    {email: 'nosuri@example.com', account_name: 'nosuri', password: 'password', prefecture: '埼玉県', introduction: '無人販売所巡るの楽しいです。', user_icon: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.jpg"), filename:"sample-user5.jpg")}
  ]
)

manufacturers = Manufacturer.create!(
  [
    {email: 'daikon@example.com', account_name: 'Daikon-farmer', password: 'password', prefecture: '埼玉県', introduction: '大根とネギを育てています。' , manufacturer_icon: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-manufacturer1.jpg"), filename:"sample-manufacturer1.jpg")},
    {email: 'mikan@example.com', account_name: 'Kankitu-orchard', password: 'password', prefecture: '愛媛県', introduction: '柑橘系を育てています。だいたい８こ入り３００円くらいで販売しています。' , manufacturer_icon: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-manufacturer2.jpg"), filename:"sample-manufacturer2.jpg")},
    {email: 'muscat@example.com', account_name: 'Muscat-farmer', password: 'password', prefecture: '東京都', introduction: 'マスカットを育てています。形の悪いものを安く販売しています。' , manufacturer_icon: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-manufacturer3.jpg"), filename:"sample-manufacturer3.jpg")},
    {email: 'corn@example.com', account_name: 'Corn-ya', password: 'password', prefecture: '北海道', introduction: 'とうもろこしを販売しています。' , manufacturer_icon: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-manufacturer4.jpg"), filename:"sample-manufacturer4.jpg")},
    {email: 'cabbage@example.com', account_name: 'Cabbage-farmer', password: 'password', prefecture: '福岡県', introduction: '葉物野菜を中心に生産しています。電子決済にも対応しました！', manufacturer_icon: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-manufacturer5.jpg"), filename:"sample-manufacturer5.jpg")}
  ]
)

Location.create!(
  [
    {name: '販売所1',postal_code: '0000000',prefecture: '埼玉県',address: 'さいたま市１－１',introduction:'畑の横にあります。', location_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-location1.jpg"), filename:"sample-location1.jpg"), manufacturer_id: 1 },
    {name: '１',postal_code: '0000000',prefecture: '愛媛県',address: '松山市２－１',introduction:'道沿いにあります。', location_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-location2.jpg"), filename:"sample-location2.jpg"), manufacturer_id: 2 },
    {name: 'マスカット販売所',postal_code: '0000000',prefecture: '東京都',address: '江戸川区３－１',introduction:'駐車場もあります。', location_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-location3.jpg"), filename:"sample-location3.jpg"), manufacturer_id: 3 },
    {name: '畑１',postal_code: '0000000',prefecture: '北海道',address: '函館市４－１',introduction:'家の隣に設置してます。', location_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-location4.jpg"), filename:"sample-location4.jpg"), manufacturer_id: 4 },
    {name: 'キャベツ用',postal_code: '0000000',prefecture: '福岡県',address: '博多区５－１',introduction:'キャベツ畑の一角になります。分かりにくい場合は000-0000-0000までご連絡ください。', location_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-location5.jpg"), filename:"sample-location5.jpg"), manufacturer_id: 5 },
    {name: 'その他もあり',postal_code: '0000000',prefecture: '福岡県',address: '博多区５－２',introduction:'その日によっていろいろな商品を置いています。', location_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-location6.jpg"), filename:"sample-location6.jpg"), manufacturer_id: 5 }
  ]
)
