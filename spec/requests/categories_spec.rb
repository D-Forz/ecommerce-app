require 'rails_helper'

RSpec.describe "Categories", type: :request do # rubocop:disable Metrics/BlockLength
  let!(:category) { create(:category, :electronics) }
  describe "GET /categories" do
    it "return http status 200 and render the index template" do
      get categories_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template("index")
    end
  end

  describe "GET /categories/new" do
    it "return http status 200 and render the new template" do
      get new_category_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template("new")
    end
  end

  describe "POST /categories" do
    let(:valid_attributes) { category.attributes }
    context "with valid attributes" do
      it "return http status 302 and redirect the show template" do
        expect do
          post categories_path, params: { category: valid_attributes }
        end.to change(Category, :count).by(1)

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(categories_path)
      end
    end

    context "with invalid attributes" do
      it "return http status 422 and render the new template" do
        expect do
          post categories_path, params: { category: { name: nil } }
        end.to change(Category, :count).by(0)

        expect(response).to render_template("new")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /categories/:id" do
    let(:new_attributes) { { name: "Category 2" } }
    context "with valid attributes" do
      it "return http status 302 and updates the category" do
        put category_path(category), params: { category: new_attributes }

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(categories_path)
      end
    end

    context "with invalid attributes" do
      it "return http status 422 and render the edit template" do
        put category_path(category), params: { category: { name: nil } }

        expect(response).to render_template("edit")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /categories/:id" do
    it "return http status 302 and destroy the category" do
      expect do
        delete category_path(category)
      end.to change(Category, :count).by(-1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(categories_path)
    end
  end
end
