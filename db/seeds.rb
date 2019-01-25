# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([{email: "kuba@wp.pl", password: "haslo123"}, {email: "jurek@wp.pl", password: "haslo123"}, {email: "agatka@wp.pl", password: "haslo123"}])
7.times { User.create(email: Faker::Internet.unique.email, password: "haslo123")}

User.all.each do |user|
  5.times {user.articles.create(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph)}
end

User.all.each do |user|
  10.times {user.comments.create(body: Faker::Friends.quote, article_id: rand(50) + 1)}
end
