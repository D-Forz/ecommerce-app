require 'rails_helper'

RSpec.describe FetchCountryJob do
  describe "enqueue job" do
    it "enqueue job" do
      ActiveJob::Base.queue_adapter = :test
      expect { described_class.perform_later("1", "0.0.0.0") }.to have_enqueued_job
    end
  end
end
