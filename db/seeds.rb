# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

emails = ["test@test.com", "test2@test.com", "test3@test.com"]
emails.each do |email|
  User.create(
    email: email,
    password: "testtest",
    admin: true
  )
  puts "#{email} created"
end

categories = ["Cleanser", "Serum", "Ampoule", "Moisturiser", "Sheet Masks", "Eye Creams", "Exfoliators", "Face Oils"]
categories.each do |category|
  Category.create(name: category)
  puts "#{category} created"
end

brands = ["Missha", "Dear, Klairs", "Banila Co", "Goodal", "IOPE.", "Dr Jart+", "Blossom Jeju", "Skinfood", "Sulwhasoo", "Laneige", "Punkyang Yul", "Tony Moly"]
brands.each do |brand|
Brand.create(
  name: brand
)
puts "#{brand} created"
end

ingredients = ["AHA", "DHA", "Niacinamide", "Retinol", "Glycerin", "Witch Hazel", "Salicylic Acid", "Lactic Acid", "Ascorbic Acid", "Benzyl Peroxide", "Aloe Vera", "Co-Q10", "Green Tea"]
ingredients.each do |ingredient|
Ingredient.create(
  name: ingredient
)
puts "#{ingredient} created"
end

for i in 1..6
product_name = ["Soft Moist Moisturising Cream", "I'm Real Mask Sheet", "Rice Water Brightening Cleanser", "Bio-Peel Gauze Peelign Wine", "Supple Preparation Uncscented Toner", "Advance Snail Mucin 96 Snail Essence", "Relief Moisture Green Ampoule"]

Product.create(
  user_id: (1..3).to_a.sample,
  category_id: (1..5).to_a.sample,
  brand_id: (1..10).to_a.sample,
  name: product_name.sample,
  price: (20..100).to_a.sample,
  description: "A light weight moisturising cream suitable for sensitive skin"
)

end

UserInfo.create(
  user_id: 1,
  first_name: "admin",
  surname: "admin",
  gender: 2
)

UserInfo.create(
  user_id: 2,
  first_name: "test user",
  surname: "test",
  gender: 4
)

for i in 1..20
ProductIngredient.create(
  product_id: (1..5).to_a.sample,
  ingredient_id: (1..10).to_a.sample
)
end

