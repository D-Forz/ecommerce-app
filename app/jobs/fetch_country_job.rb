class FetchCountryJob < ApplicationJob
  queue_as :default

  def perform(user_id, ip)
    # Do something later
    country = FetchCountryService.new(ip).perform
    user = User.find(user_id)
    user.update(country:) if country
  end
end
