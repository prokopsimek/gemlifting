class GemObject < ApplicationRecord
  has_many :versions, class_name: GemVersion
  alias gem_versions versions

  def github_uri
    gh_uri = source_code_uri || homepage_uri
    gh_uri &.include?('github.com') ? gh_uri : nil
  end

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

end
