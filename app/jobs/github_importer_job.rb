class GithubImporterJob < SidekiqJobBase
  sidekiq_options unique: :while_executing

  def perform
    Rails.logger.info "==== GithubImporterJob START ===="
    start_time = Time.now

    # select only s many objects as Github rate limit
    gem_object_ids_to_sync = GemObject
                            .where("source_code_uri ILIKE ? OR homepage_uri ILIKE ?", "%github%", "%github%")
                            .order("github_sync_at ASC NULLS FIRST")
                            .limit(GITHUB_RATE_LIMIT + 100)
                            .ids

    gem_object_ids_to_sync.each do |gem_object_id|
      begin
        gem_object = GemObject.find(gem_object_id)
        Rails.logger.info "##{gem_object.id} #{gem_object.name}"
        Services::GithubImporter.new.import_github_stats(gem_object) # import stats via Github API
        Services::GithubImporter.new.import_github_readme(gem_object) # save readme via Github API
      rescue Octokit::TooManyRequests => error
        Rails.logger.error error
        break # abort
      end
    end

    Rails.logger.info "==== GithubImporterJob END - It took: #{TimeDifference.between(start_time, Time.now).in_general} ===="
  end

end
