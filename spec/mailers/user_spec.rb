require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome" do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.with(user:).welcome }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome to MyShop")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["no-reply@myshop.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Welcome to MyShop, #{user.username}!")
    end
  end

end
