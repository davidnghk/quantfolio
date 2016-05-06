class RefreshStatsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Vehicle.get_history
  end
end
