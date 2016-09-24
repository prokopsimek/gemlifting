class RubygemsSyncJob < SidekiqJobBase
  def perform
    Rails.logger.info "==== RubygemsSyncJob START ===="
    start_time = Time.now

    # Returns the 50 gems most recently added to RubyGems.org
    Client::Rubygems.names_of_latest.each do |new_gem_name|
      Services::RubygemsImporter.new.import(new_gem_name)
    end

    # Returns the 50 most recently updated gems
    Client::Rubygems.names_of_just_updated do |updated_gem_name|
      Services::RubygemsImporter.new.import(updated_gem_name)
    end

    Rails.logger.info "==== RubygemsSyncJob END - GemObjects count: #{GemObject.count}; It took: #{TimeDifference.between(start_time, Time.now).in_general} ===="
  end

end
