# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Language.create(lang: 'Arabic')
Language.create(lang: 'Bahasa Indonesia')
Language.create(lang: 'Chinese')
Language.create(lang: 'French')
Language.create(lang: 'German')
Language.create(lang: 'Hindi')
Language.create(lang: 'Japanese')
Language.create(lang: 'Korean')
Language.create(lang: 'Malay')
Language.create(lang: 'Spanish')
Language.create(lang: 'Tamil')
Language.create(lang: 'Thai')
Language.create(lang: 'Vietnamese')

list = ['Arabic', 'Bahasa Indonesia', 'Chinese', 'French', 'German', 'Hindi', 
  'Japanese','Korean', 'Malay', 'Spanish', 'Tamil', 'Thai, 'Vietnamese']
list.each do |tag|
  ActsAsTaggableOn::Tag.new(:name => tag).save
end