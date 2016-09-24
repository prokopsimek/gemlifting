class Services::GithubImporter

  def import_github_stats(gem_object)
    gh_uri = gem_object.github_uri

    if gh_uri.present?
      begin
        repo_hash = Client::Github.new.get_repo_info_hash(gh_uri)

        gem_object.save_github_stats(repo_hash)
        return self
      rescue Octokit::InvalidRepository
        Rails.logger.error "Invalid repository: #{gh_uri}"
      rescue Octokit::NotFound => e
        Rails.logger.error e
      end
    end
    false
  end

end
