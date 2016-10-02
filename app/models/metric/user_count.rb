class Metric::UserCount < Metric::Metric
  def self.measure_current_value
    User.count
  end

  def self.measure_past_value(date)
    User.where('created_at <= ?', date).count
  end
end
