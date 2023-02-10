require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let!(:user) { create(:user) }
  describe "GET /session/new" do
    it "return http status 200 and render the new template" do
      get new_session_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template("new")
    end
  end

  describe "POST /session" do
    context "with valid parameters" do
      it "create a new session" do
        post sessions_path, params: { login: user.username, password: user.password }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new session" do
        post sessions_path, params: { login: nil, password: 123_456 }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
