class Metric::GemObjectsGithubSyncedInLastDayCount < Metric::Metric
  def self.measure_current_value
    base_model.count
  end

  private

  def self.base_model
    GemObject.where('github_sync_at >= ?', DateTime.now - 1.day)
  end

end
