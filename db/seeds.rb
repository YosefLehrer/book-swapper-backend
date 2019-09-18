# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

yosef = User.create(user_name: "yoseflehrer", password: "12345678")
harry = Book.create(title: "Harry Potter", author: "Rolling Stones", ISBN: 12345678, img: "iaaksdiu")
joinedbook = OwnedBook.create(book_id: Book.all.first.id, user_id: User.all.first.id)