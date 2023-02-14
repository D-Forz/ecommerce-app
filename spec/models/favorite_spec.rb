# == Schema Information
#
# Table name: favorites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_favorites_on_product_id              (product_id)
#  index_favorites_on_user_id                 (user_id)
#  index_favorites_on_user_id_and_product_id  (user_id,product_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Favorite, type: :model do
  subject(:favorite) { create(:favorite) }
  describe 'validations' do
    it { should validate_uniqueness_of(:user_id).scoped_to(:product_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end
end
