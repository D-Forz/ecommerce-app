# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  admin           :boolean          default(FALSE)
#  country         :string
#  email           :string           not null
#  password_digest :string           not null
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{n}@example.com" }
    sequence(:username) { |n| "username#{n}" }
    password { "123456" }

    trait :invalid do
      email { nil }
    end

    trait :admin do
      admin { true }
    end

    trait :testing_user do
      username { "testing_user" }
    end
  end
end
