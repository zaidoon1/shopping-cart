# Populates the database with fake data
# using the gem Faker. This data will be used
# to ensure the API works as intended

# Generates 20 rows populated with random data in the database
#
20.times do
  Product.create(
    title: Faker::Commerce.product_name,
    price: Faker::Commerce.price,
    inventory_count: Faker::Number.between(0, 10_000)
  )
end

# Generates a product that is not in stock. This makes testing the retrieve all
# products in stock request easier
Product.create(
  title: 'The coolest product on the planet',
  price: 10_000.25,
  inventory_count: 0
)
