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
    GemObject.where.not(github_sync_at: nil).count
  end

  def self.measure_past_value(date)
    GemObject.where.not(github_sync_at: nil).where('created_at <= ?', date).count
  end
end

class Metric::GemObjectsGithubSyncedInLastDayCount < Metric::Metric
  def self.measure_current_value
    GemObject.where('github_sync_at >= ?', DateTime.now - 1.day).count
  end
end

class Metric::GemObjectsRubygemsSyncedCount < Metric::Metric
  def self.measure_current_value
    GemObject.where.not(rubygems_sync_at: nil).count
  end

  def self.measure_past_value(date)
    GemObject.where.not(rubygems_sync_at: nil).where('created_at <= ?', date).count
  end
end

class Metric::GemObjectsRubygemsSyncedInLastDayCount < Metric::Metric
  def self.measure_current_value
    GemObject.where('rubygems_sync_at >= ?', DateTime.now - 1.day).count
  end
end

class Metric::GemObjectsWithCategoryCount < Metric::Metric
  def self.measure_current_value
    GemObject.where.not(gem_category_id: nil).count
  end

  def self.measure_past_value(date)
    GemObject.where.not(gem_category_id: nil).where('created_at <= ?', date).count
  end
end

class Metric::GemObjectsWithReadmeCount < Metric::Metric
  def self.measure_current_value
    GemObject.where.not(readme: nil).count
  end

  def self.measure_past_value(date)
    GemObject.where.not(readme: nil).where('created_at <= ?', date).count
  end
end

class Metric::GemObjectsWithGithubUriInHomepageUriCount < Metric::Metric
  def self.measure_current_value
    GemObject.where("homepage_uri ILIKE '%github%'").count
  end

  def self.measure_past_value(date)
    GemObject.where("homepage_uri ILIKE '%github%'").where('created_at <= ?', date).count
  end
end

class Metric::GemObjectsWithGithubUriInSourceCodeUriCount < Metric::Metric
  def self.measure_current_value
    GemObject.where("source_code_uri ILIKE '%github%'").count
  end

  def self.measure_past_value(date)
    GemObject.where("source_code_uri ILIKE '%github%'").where('created_at <= ?', date).count
  end
end

class Metric::GemObjectsWithGithubUriInHomepageUriOrSourceCodeUriCount < Metric::Metric
  def self.measure_current_value
    GemObject.where("homepage_uri ILIKE '%github%' OR source_code_uri ILIKE '%github%'").count
  end

  def self.measure_past_value(date)
    GemObject.where("homepage_uri ILIKE '%github%' OR source_code_uri ILIKE '%github%'").where('created_at <= ?', date).count
  end
end
