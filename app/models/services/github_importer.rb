class Services::GithubImporter

  def import_github_stats(gem_object)
    gh_uri = gem_object.github_uri

    get_info(gh_uri) do
      repo_hash = Client::Github.new.get_repo_info_hash(gh_uri)

      gem_object.update!(
        description: repo_hash[:description],
        git_url: repo_hash[:git_url],
        ssh_url: repo_hash[:ssh_url],
        stargazers_count: repo_hash[:stargazers_count],
        watchers_count: repo_hash[:watchers_count],
        forks_count: repo_hash[:forks_count],
        open_issues_count: repo_hash[:open_issues_count],
        github_sync_at: DateTime.now,
        bug_tracker_uri: (repo_hash[:issues_url].gsub!('{/number}', '') if repo_hash[:has_issues].to_s == 'true')
      )

      return self
    end
  end

  def import_github_readme(gem_object)
    gh_uri = gem_object.github_uri

    get_info(gh_uri) do
      readme_content = Client::Github.new.get_repo_readme(gh_uri)
      gem_object.update!(readme: readme_content)
      return self
    end
  end

  private

  def get_info(gh_uri)
    if gh_uri.present?
      begin
        yield
      rescue Octokit::InvalidRepository
        Rails.logger.error "Invalid repository: #{gh_uri}"
      rescue Octokit::NotFound => e
        Rails.logger.error e
      end
      ap "processed gh_uri"
    end
    ap gh_uri
    false
  end

end
