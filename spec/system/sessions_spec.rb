require 'rails_helper'

RSpec.describe "Sessions Managment" do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test)
  end

  describe "GET /login" do
    context "when user is not logged in" do
      it "allows a user to login" do
        visit new_session_path
        fill_in "Login", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
        expect(page).to have_content("You have logged in")
      end
    end

    context "when user is logged in" do
      before do
        sign_in user
      end

      it "redirects to products page" do
        visit new_session_path
        expect(page).to redirect_to(products_path)
      end
    end
  end
end
