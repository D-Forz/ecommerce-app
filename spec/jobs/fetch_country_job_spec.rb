require 'rails_helper'

RSpec.describe FetchCountryJob, type: :job do
  describe "enqueue job" do
    it "should enqueue job" do
      ActiveJob::Base.queue_adapter = :test
      expect { FetchCountryJob.perform_later("1", "0.0.0.0") }.to have_enqueued_job
    end
  end
end
