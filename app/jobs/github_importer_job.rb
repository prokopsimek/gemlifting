class GithubImporterJob < SidekiqJobBase
  def perform
    Rails.logger.info "==== GithubImporterJob START ===="
    start_time = Time.now

    # select only s many objects as Github rate limit
    gem_objects_to_sync = GemObject.order("github_sync_at ASC NULLS FIRST").limit(GITHUB_RATE_LIMIT + 100)

    gem_objects_to_sync.find_each do |gem_object|
      begin
        Services::GithubImporter.new.import_github_stats(gem_object) # import stats via Github API
      rescue Octokit::TooManyRequests => error
        Rails.logger.error error
        break # abort
      end
    end

    Rails.logger.info "==== GithubImporterJob END - It took: #{TimeDifference.between(start_time, Time.now).in_general} ===="
  end

end
