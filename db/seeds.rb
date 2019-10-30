# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  email: "test@test.com",
  password: "testtest"
  admin: true
)

Category.create(name: "moisturiser")

Brand.create(
  name: "Klairs"
)

Ingredient.create(
  name: "hyaluronic acid"
)

Product.create(
  user_id: 1,
  category_id: 1,
  brand_id: 1,
  name: "Soft Moist Moisturising Cream",
  price: 19.95,
  description: "A light weight moisturising cream suitable for sensitive skin"
)

UserInfo.create(
  user_id: 1,
  first_name: "admin",
  surname: "admin",
  gender: 0
)

