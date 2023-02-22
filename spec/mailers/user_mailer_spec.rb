require "rails_helper"

RSpec.describe UserMailer do
  describe "welcome" do
    let(:user) { create(:user, username: "john") }
    let(:mail) { described_class.with(user:).welcome }

    it "renders the subject" do
      expect(mail.subject).to eq("Welcome to MyShop, john!")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Welcome to MyShop, #{user.username}!")
    end
  end
end
