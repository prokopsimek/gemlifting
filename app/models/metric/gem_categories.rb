class Metric::GemCategoriesCount < Metric::Metric
  def self.measure_current_value
    GemCategory.count
  end

  def self.measure_past_value(date)
    GemCategory.where('created_at <= ?', date).count
  end
end
