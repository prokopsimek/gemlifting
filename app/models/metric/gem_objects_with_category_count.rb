class Metric::GemObjectsWithCategoryCount < Metric::Metric
  def self.measure_current_value
    base_model.count
  end

  def self.measure_past_value(date)
    base_model.where('created_at <= ?', date).count
  end

  private

  def self.base_model
    GemObjectInGemCategory.distinct(:gem_object_id)
  end

end
