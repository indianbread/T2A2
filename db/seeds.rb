# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

emails = ["test@test.com", "test2@test.com", "test3@test.com"]
emails.each do |email|
  User.create(
    email: email,
    password: "testtest",
    admin: true
  )
  puts "#{email} created"
end

for i in 1..20
  User.create(
    email: Faker::Internet.email,
    password: "testtest",
    admin: false
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
  first_name: "test admin 2",
  surname: "test",
  gender: 4
)

UserInfo.create(
  user_id: 3,
  first_name: "admin 3",
  surname: "admin",
  gender: 2
)

user_ids_1 = (4..23).to_a
user_ids_1.each do |id|
  UserInfo.create(
    user_id: id,
    first_name: Faker::Name.first_name,
    surname: Faker::Name.last_name,
    gender: [2,4].sample
  )
end

  user_ids_2 = (1..23).to_a
  states = ["VIC", "ACT", "NSW", "QLD", "TAS", "NT", "WA"]
  user_ids_2.each do |id|
    Address.create(
      street_number: Faker::Address.street_address,
      suburb: Faker::Address.community,
      postcode: Faker::Number.within(range:3000..3200),
      state:states.sample,
      country: "Australia"
    )
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

for i in 1..30
product_name = ["Soft Moist Moisturising Cream", "I'm Real Mask Sheet", "Rice Water Brightening Cleanser", "Bio-Peel Gauze Peelign Wine", "Supple Preparation Uncscented Toner", "Advance Snail Mucin 96 Snail Essence", "Relief Moisture Green Ampoule"]
product_description = [ "A light weight moisturising cream suitable for sensitive skin","a hydrating and exfoliating toner that preps your skin for the rest of your skincare routine", "a mild exfoliating cream that helps hydrate, decongest, exfoliate and clear out impurities from the skin", "a gentle acne-fighting and soothing cleanser", "a soothing and cooling mask that instantly hydrates and nourishes the skin", "a moisturising, brightening and anti-wrinkle treatment for your eyes", "an oil-free ampoule that's perfect for hydrating oily but dehydrated skin"]
files = ["prod1.jpeg","prod2.jpeg","prod3.jpg","prod4.jpg","prod5.jpeg","prod6.jpeg"]
paths = ["app/assets/images/products/prod1.jpeg","app/assets/images/products/prod2.jpeg","app/assets/images/products/prod3.jpg","app/assets/images/products/prod4.jpg", "app/assets/images/products/prod5.jpeg", "app/assets/images/products/prod6.jpeg"]
index = (1..5).to_a.sample
file = files[index]
path = paths[index]
product = Product.create(
              user_id: (4..23).to_a.sample,
              category_id: (1..5).to_a.sample,
              brand_id: (1..10).to_a.sample,
              name: product_name.sample,
              price: (20..100).to_a.sample,
              description: product_description.sample
              )
product.picture.attach(io: File.open(path), filename: file)
product.save
puts "product created"
end

prod_ids = (1..30).to_a
prod_ids.each do |id|
ProductIngredient.create(
  product_id: id,
  ingredient_id: (1..10).to_a.sample
)
end






