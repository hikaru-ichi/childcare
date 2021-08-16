# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

columns = [ 
  '補助金制度',
  '育休',
  'ベビー用品',
  '出産',
  '授乳',
  'お風呂',
  '保育園',
  '離乳食'
  ]
  
columns.each_with_index do |column, i|
  Category.create(id: i, name: column)
end