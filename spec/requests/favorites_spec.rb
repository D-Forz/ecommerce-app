require 'rails_helper'

RSpec.describe "Favorites", type: :request do # rubocop:disable Metrics/BlockLength
  let!(:user) { create(:user) }
  let!(:product) { create(:product) }

  before(:each) do
    sign_in user
  end

  describe "GET /favorites" do
    it "return http status 200 and render the index template" do
      get favorites_path
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
    end
  end

  describe "POST /favorites" do
    it "should create a favorite" do
      expect do
        post favorites_path(product_id: product.id)
      end.to change(Favorite, :count).by(1)

      expect(response).to redirect_to(product_path(product))
    end
  end

  describe "DELETE /favorite/:id" do
    it "should delete a favorite" do
      create(:favorite, user:, product:)
      expect do
        delete favorite_path(product_id: product.id)
      end.to change(Favorite, :count).by(-1)

      expect(response).to redirect_to(product_path(product))
    end
  end
end
