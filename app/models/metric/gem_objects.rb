class Metric::GemObjectsCount < Metric::Metric
  def self.measure_current_value
    GemObject.count
  end

  def self.measure_past_value(date)
    GemObject.where('created_at <= ?', date).count
  end
end

class Metric::GemObjectsGithubSyncedCount < Metric::Metric
  def self.measure_current_value
    base_model.count
  end

  def self.measure_past_value(date)
    base_model.where('created_at <= ?', date).count
  end

  private

  def self.base_model
    GemObject.where.not(github_sync_at: nil)
  end
end

class Metric::GemObjectsGithubSyncedInLastDayCount < Metric::Metric
  def self.measure_current_value
    base_model.count
  end

  private

  def self.base_model
    GemObject.where('github_sync_at >= ?', DateTime.now - 1.day)
  end
end

class Metric::GemObjectsRubygemsSyncedCount < Metric::Metric
  def self.measure_current_value
    base_model.count
  end

  def self.measure_past_value(date)
    base_model.where('created_at <= ?', date).count
  end

  private

  def self.base_model
    GemObject.where.not(rubygems_sync_at: nil)
  end
end

class Metric::GemObjectsRubygemsSyncedInLastDayCount < Metric::Metric
  def self.measure_current_value
    base_model.count
  end

  private

  def self.base_model
    GemObject.where('rubygems_sync_at >= ?', DateTime.now - 1.day)
  end
end

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

class Metric::GemObjectsWithGithubUriInHomepageUriCount < Metric::Metric
  def self.measure_current_value
    base_model.count
  end

  def self.measure_past_value(date)
    base_model.where('created_at <= ?', date).count
  end

  private

  def self.base_model
    GemObject.where("homepage_uri ILIKE '%github%'")
  end
end

class Metric::GemObjectsWithGithubUriInSourceCodeUriCount < Metric::Metric
  def self.measure_current_value
    base_model.count
  end

  def self.measure_past_value(date)
    base_model.where('created_at <= ?', date).count
  end

  private

  def self.base_model
    GemObject.where("source_code_uri ILIKE '%github%'")
  end
end

class Metric::GemObjectsWithGithubUriInHomepageUriOrSourceCodeUriCount < Metric::Metric
  def self.measure_current_value
    def self.measure_current_value
      base_model.count
    end

    def self.measure_past_value(date)
      base_model.where('created_at <= ?', date).count
    end

    private

    def self.base_model
      GemObject.where("homepage_uri ILIKE '%github%' OR source_code_uri ILIKE '%github%'")
    end
  end
end
