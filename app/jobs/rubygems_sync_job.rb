class RubygemsSyncJob < SidekiqJobBase
  def perform
    Rails.logger.info "==== RubygemsSyncJob START ===="
    start_time = Time.now

    # Returns the 50 gems most recently added to RubyGems.org
    GemRepo.names_of_latest.each do |new_gem_name|
      GemImporter.new(new_gem_name).import
    end

    # Returns the 50 most recently updated gems
    GemRepo.names_of_just_updated do |updated_gem_name|
      GemImporter.new(updated_gem_name).import
    end

    Rails.logger.info "==== RubygemsSyncJob END - GemObjects count: #{GemObject.count}; It took: #{TimeDifference.between(start_time, Time.now).in_general} ===="
  end

end
