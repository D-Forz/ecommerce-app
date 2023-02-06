require 'rails_helper'

RSpec.describe "Products", type: :request do # rubocop:disable Metrics/BlockLength
  let!(:product) { create(:product) }
  describe "GET /products" do
    it "return http status 200 and render the index template" do
      get products_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template("index")
    end
  end

  describe "GET /products/:id" do
    it "return http status 200 and render the show template" do
      get product_path(product)
      expect(response).to have_http_status(:success)
      expect(response).to render_template("show")
    end
  end

  describe "POST /products" do
    let(:valid_attributes) { product.attributes }
    context "with valid attributes" do
      it "return http status 302 and redirect the show template" do
        expect do
          post products_path, params: { product: valid_attributes }
        end.to change(Product, :count).by(1)

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(product_path(Product.last))
      end
    end

    context "with invalid attributes" do
      it "return http status 200 and render the new template" do
        expect do
          post products_path, params: { product: { title: nil } }
        end.to change(Product, :count).by(0)

        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT /products/:id" do
    let(:new_attributes) { { title: "Product 2", price: 11.99 } }
    context "with valid attributes" do
      it "return http status 302 and updates the product" do
        put product_path(product), params: { product: new_attributes }

        expect(response).to have_http_status(:redirect)
        expect(product.reload.title).to eq("Product 2")
      end
    end

    context "with invalid attributes" do
      it "return http status 200 and doesn't update the product" do
        put product_path(product), params: { product: { title: nil } }

        expect(response).to render_template("edit")
        expect(product.reload.title).to eq(product.title)
      end
    end
  end

  describe "DELETE /products/:id" do
    it "return http status 302 and delete the requested product" do
      expect do
        delete product_path(product)
      end.to change(Product, :count).by(-1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(products_path)
    end
  end
end
