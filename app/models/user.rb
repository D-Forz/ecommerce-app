# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
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
class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true,
                    format: {
                      with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
                      message: :invalid
                    }
  validates :username, presence: true, uniqueness: true,
                       length: { in: 3..15 },
                       format: {
                         with: /\A[a-zA-Z0-9]+\z/,
                         message: :invalid
                       }
  validates :password, length: { minimum: 6 }

  before_save :downcase_attributes

  private

  def downcase_attributes
    self.username = username.downcase
    self.email = email.downcase
  end
end
