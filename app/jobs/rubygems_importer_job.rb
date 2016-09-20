class RubygemsImporterJob < SidekiqJobBase
  sidekiq_options unique: :while_executing

  def perform
    Rails.logger.info "==== RubygemsImporterJob START ===="
    start_time = Time.now

    rubygems_instance = GemRepo.new

    Rails.logger.info "==== RubygemsImporterJob gems count: #{rubygems_instance.size} ===="

    new_gems_names = (rubygems_instance.names - GemObject.all.pluck(:name))

    # first process new gems
    new_gems_names.each do |new_gem_name|
      GemImporter.new(new_gem_name).import
    end

    # process gems ordered by oldest rubygems sync
    GemObject.order(rubygems_sync_at: :asc).find_each do |gem_object|
      GemImporter.new(gem_object.name).import
    end

    Rails.logger.info "==== RubygemsImporterJob END - GemObjects count: #{GemObject.count}; It took: #{TimeDifference.between(start_time, Time.now).in_general} ===="
  end

end
