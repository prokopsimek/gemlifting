class Services::GithubImporter

  def import_github_stats(gem_object)
    gh_uri = gem_object.github_uri

    get_info(gh_uri) do
      repo_hash = Client::Github.new.get_repo_info_hash(gh_uri)

      gem_object.save_github_stats(repo_hash)
      return self
    end
  end

  def import_github_readme(gem_object)
    gh_uri = gem_object.github_uri

    get_info(gh_uri) do
      Rails.logger.info gem_object.inspect
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
    end
    false
  end

end
