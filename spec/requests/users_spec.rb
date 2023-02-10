require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/new" do
    it "return http status 200 and render the new template" do
      get new_user_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template("new")
    end
  end

  describe "POST /users" do
    context "with valid parameters" do
      it "create a new user" do
        expect do
          post users_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new user" do
        post users_path, params: { user: attributes_for(:user, :invalid) }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template("new")
      end
    end
  end
end
