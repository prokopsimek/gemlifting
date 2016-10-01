class Metric::GemObjectsWithReadmeCount < Metric::Metric
  def self.measure_current_value
    base_model.count
  end

  def self.measure_past_value(date)
    base_model.where('created_at <= ?', date).count
  end

  private

  def self.base_model
    GemObject.where.not(readme: nil)
  end

end
