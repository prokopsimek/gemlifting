class Metric::GemObjectsCount < Metric::Metric
  def self.measure_current_value
    GemObject.count
  end

  def self.measure_past_value(date)
    GemObject.where('created_at <= ?', date).count
  end

end
