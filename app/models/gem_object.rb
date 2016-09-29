class GemObject < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_many :gem_object_in_gem_categories, inverse_of: :gem_object
  has_many :gem_categories, through: :gem_object_in_gem_categories, inverse_of: :gem_objects
  has_many :versions, class_name: GemVersion

  validates :slug, uniqueness: true

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
    description = repo_hash['description']
    git_url = repo_hash['git_url']
    ssh_url = repo_hash['ssh_url']
    stargazers_count = repo_hash['stargazers_count']
    watchers_count = repo_hash['watchers_count']
    forks_count = repo_hash['forks_count']
    open_issues_count = repo_hash['open_issues_count']
    github_sync_at = DateTime.now

    if repo_hash['has_issues'].to_s == 'true' && bug_tracker_uri.blank?
      bug_tracker_uri = repo_hash['issues_url'].gsub!('{/number}', '')
    end

    save!
  end

  def html_readme
    return nil if readme.nil?

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(link_attributes: { target: '_blank' }), autolink: true)
    markdown.render(readme).html_safe
  end

  def lastmod_at
    newest_date = updated_at
    newest_date = github_sync_at if github_sync_at.present? && github_sync_at > newest_date
    newest_date = rubygems_sync_at if rubygems_sync_at.present? && rubygems_sync_at > newest_date
    newest_date
  end

  private

  def slug_candidates
    parameterized_name = name.parameterize.dasherize
    [
      parameterized_name,
      [parameterized_name, "gem"]
    ]
  end

end
