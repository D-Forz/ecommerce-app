require 'rails_helper'

RSpec.describe "Products", type: :request do # rubocop:disable Metrics/BlockLength
  let!(:user) { create(:user) }
  let!(:product) { create(:product, user:) }

  before(:each) do
    post sessions_path, params: { login: user.username, password: user.password }
  end

  describe "GET /products" do # rubocop:disable Metrics/BlockLength
    it "return http status 200 and render the index template" do
      get products_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template("index")
    end

    it "render a list of products filtered by category" do
      category = create(:category, name: "New Category")
      product.update(category:)
      get products_path(category_id: category.id)
      expect(response.body).to include(product.title)
    end

    it "render a list of products filtered by min_price" do
      get products_path(min_price: product.price)
      expect(response.body).to include(product.title)
    end

    it "render a list of products filtered by max_price" do
      get products_path(max_price: product.price)
      expect(response.body).to include(product.title)
    end

    it "render a list of products filtered by query_text" do
      get products_path(query_text: product.title)
      expect(response.body).to include(product.title)
    end

    it "sort products by newest" do
      get products_path(order_by: :newest)
      expect(response.body).to include(product.title)
    end

    it "sort products by expensive" do
      get products_path(order_by: :expensive)
      expect(response.body).to include(product.title)
    end

    it "sort products by cheapest" do
      get products_path(order_by: :cheapest)
      expect(response.body).to include(product.title)
    end
  end

  describe "GET /products/new" do
    it "return http status 200 and render the new template" do
      get new_product_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template("new")
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
      it "return http status 422 and render the new template" do
        expect do
          post products_path, params: { product: { title: nil } }
        end.to change(Product, :count).by(0)

        expect(response).to render_template("new")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /products/:id" do
    context "with valid attributes" do
      it "return http status 302 and redirect the show template" do
        put product_path(product), params: { product: { title: "New Title" } }

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(product_path(product))
        expect(product.reload.title).to eq("New Title")
      end
    end

    context "with invalid attributes" do
      it "return http status 422 and render the edit template" do
        put product_path(product), params: { product: { title: nil } }

        expect(response).to render_template("edit")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /products/:id" do
    it "return http status 302 and redirect the index template" do
      expect do
        delete product_path(product)
      end.to change(Product, :count).by(-1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(products_path)
    end
  end
end
