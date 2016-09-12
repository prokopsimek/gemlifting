class GemObject < ApplicationRecord
  has_many :versions, class_name: GemVersion
  alias gem_versions versions

  def import_github_stats
    gh_uri = github_uri

    if gh_uri.present?
      begin
        repo_hash = get_repo_info_hash(gh_uri)

        save_github_stats(repo_hash)
        return self
      rescue Octokit::InvalidRepository
        logger.error "Invalid repository: #{gh_uri}"
      rescue Octokit::NotFound => e
        logger.error e
      end
    end
    false
  end

  def github_uri
    gh_uri = source_code_uri || homepage_uri
    gh_uri &.include?('github.com') ? gh_uri : nil
  end

  # private

  def save_github_stats(repo_hash)
    stargazers_count = repo_hash['stargazers_count']
    watchers_count = repo_hash['watchers_count']
    forks_count = repo_hash['forks_count']
    open_issues_count = repo_hash['open_issues_count']

    if repo_hash['has_issues'].to_s == 'true' && bug_tracker_uri.blank?
      bug_tracker_uri = repo_hash['issues_url'].gsub!('{/number}', '')
    end

    save!
  end

  def get_repo_info_hash(gh_uri)
    client = Octokit::Client.new #(access_token: ENV['GITHUB_API_TOKEN'])

    repo_user_and_name = get_gh_repo_string(gh_uri)

    client.repo repo_user_and_name
  end

  def get_gh_repo_string(gh_uri)
    # regex tester: https://regex101.com/r/pT7kE6/4
    regex = /(?<=github\.com\/)(?!repos)(.*?)\/(.*?)(?=\/|$)|(?<=github\.com\/repos\/)(.*?)\/(.*?)(?=\/|$)/

    gh_uri.match(regex).to_s
  end

end
