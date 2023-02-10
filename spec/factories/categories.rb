# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :category do
    name { "Electronics" }

    trait :electronics do
      name { "Electronics" }
    end

    trait :books do
      name { "Books" }
    end

    trait :clothing do
      name { "Clothing" }
    end

    trait :toys do
      name { "Toys" }
    end

    trait :sports do
      name { "Sports" }
    end
  end
end
