# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  price       :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_full_text, against: %i[title description]

  ORDER_BY = {
    newest: "created_at DESC",
    expensive: "price DESC",
    cheapest: "price ASC"
  }

  belongs_to :category
  belongs_to :user, default: -> { Current.user }
  has_one_attached :image
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  def owner?
    user == Current.user
  end
end
