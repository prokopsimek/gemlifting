class GemObject < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_many :gem_object_in_gem_categories, inverse_of: :gem_object
  has_many :gem_categories, through: :gem_object_in_gem_categories, inverse_of: :gem_objects
  has_many :versions, class_name: GemVersion

  alias gem_versions versions

  def github_uri
    gh_uri = source_code_uri || homepage_uri
    gh_uri &.include?('github.com') ? gh_uri : nil
  end

  def add_to_category!(category)
    gem_object_in_gem_categories
      .create!(gem_category: category)
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

  private

  def slug_candidates
    parameterized_name = name.parameterize
    [
      parameterized_name,
      [parameterized_name, "gem"]
    ]
  end

end
