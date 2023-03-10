require 'rails_helper'

RSpec.describe FetchCountryService do
  describe "#perform" do
    let(:ip) { "24.48.0.1" }

    context "when the ip is valid" do
      it "returns the country code" do
        stub_request(:get, "http://ip-api.com/json/#{ip}")
          .to_return(status: 200, body: {
            status: "success",
            countryCode: "CA"
          }.to_json, headers: {})
        expect(described_class.new(ip).perform).to eq("CA")
      end
    end

    context "when the ip is invalid" do
      it "returns nil" do
        stub_request(:get, "http://ip-api.com/json/invalid")
          .to_return(status: 200, body: {
            status: "fail",
            message: "invalid query"
          }.to_json, headers: {})
        expect(described_class.new("invalid").perform).to be_nil
      end
    end
  end
end
