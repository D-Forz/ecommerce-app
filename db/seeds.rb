# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'factory_bot_rails'

p "Creating categories..."
FactoryBot.create(:category, :electronics)
FactoryBot.create(:category, :books)
FactoryBot.create(:category, :clothing)
FactoryBot.create(:category, :toys)
FactoryBot.create(:category, :sports)

user = FactoryBot.create(:user)

p "Creating products..."
FactoryBot.create_list(:product, 10, category: Category.find_by(name: "Electronics"), user:)
FactoryBot.create_list(:product, 10, category: Category.find_by(name: "Books"), user:)
FactoryBot.create_list(:product, 10, category: Category.find_by(name: "Clothing"), user:)
FactoryBot.create_list(:product, 10, category: Category.find_by(name: "Toys"), user:)
FactoryBot.create_list(:product, 10, category: Category.find_by(name: "Sports"), user:)

p "Finished!"
