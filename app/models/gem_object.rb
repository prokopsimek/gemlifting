class GemObject < ApplicationRecord
  include PgSearch
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_many :gem_object_in_gem_categories, inverse_of: :gem_object
  has_many :gem_categories, through: :gem_object_in_gem_categories, inverse_of: :gem_objects
  has_many :versions, class_name: GemVersion

  validates :slug, uniqueness: true

  pg_search_scope :search_full_text, :against => {
    name: 'A',
    description: 'B'
  }

  alias gem_versions versions

  def self.search(query)
    search_full_text(query)
  end

  def github_uri
    gh_uri = source_code_uri || homepage_uri
    gh_uri &.include?('github.com') ? gh_uri : nil
  end

  def add_to_category!(category)
    gem_object_in_gem_categories
      .create!(gem_category: category)
  end

  def read_readme
    Base64.decode64(readme).force_encoding('UTF-8')
  end

  def html_readme
    return nil if readme.nil?

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(link_attributes: { target: '_blank' }), autolink: true)
    markdown.render(read_readme).html_safe
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
