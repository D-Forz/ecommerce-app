require 'rails_helper'

RSpec.describe "Users" do
  describe "GET /user/:username" do
    let(:user) { create(:user) }

    context "when the user exists" do
      it "return http status 200 and render the show template" do
        get user_path(user.username)
        expect(response).to have_http_status(:success)
        expect(response).to render_template("show")
      end
    end

    context "when the user does not exist" do
      it "redirect to the products path" do
        get user_path("invalid")
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
      end
    end
  end

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
          stub_request(:get, "http://ip-api.com/json/127.0.0.1")
            .to_return(status: 200, body: {
              status: "fail"
            }.to_json, headers: {})
          post users_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new user" do
        stub_request(:get, "http://ip-api.com/json/127.0.0.1")
          .to_return(status: 200, body: {
            status: "fail"
          }.to_json, headers: {})
        post users_path, params: { user: attributes_for(:user, :invalid) }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template("new")
      end
    end
  end
end
