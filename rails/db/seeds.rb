10.times do
  supplier = Supplier.create(name: Faker::Name::first_name)
  10.times do
    Product.create(name: Faker::Name::first_name, count: 1, description: Faker::Invoice.reference, supplier: supplier)
  end
end
