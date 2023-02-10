# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'factory_bot_rails'

FactoryBot.create(:category, :electronics)
FactoryBot.create(:category, :books)
FactoryBot.create(:category, :clothing)
FactoryBot.create(:category, :toys)
FactoryBot.create(:category, :sports)

FactoryBot.create_list(:product, 10, category: Category.find_by(name: "Electronics"))
FactoryBot.create_list(:product, 10, category: Category.find_by(name: "Books"))
FactoryBot.create_list(:product, 10, category: Category.find_by(name: "Clothing"))
FactoryBot.create_list(:product, 10, category: Category.find_by(name: "Toys"))
FactoryBot.create_list(:product, 10, category: Category.find_by(name: "Sports"))
