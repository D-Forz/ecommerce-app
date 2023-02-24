# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'factory_bot_rails'
user = FactoryBot.create(:user)
%w[electronics books clothing toys sports].each do |category|
  FactoryBot.create(:category, name: category)
  Rails.logger.info "Creating #{category} products..."
  FactoryBot.create_list(:product, 20, category: Category.find_by(name: category), user:)
end

Rails.logger.info "The database has been seeded."
