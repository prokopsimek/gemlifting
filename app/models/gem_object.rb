class GemObject < ApplicationRecord
  include PgSearch, Proposable, Searchable
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :gem_category, inverse_of: :gem_objects
  has_many :versions, -> { order(number: :desc) }, class_name: GemVersion, dependent: :destroy

  validates :slug, uniqueness: true
  validates :name, presence: true, uniqueness: true

  scope :without_category, -> { where(gem_category_id: nil) }

  alias gem_versions versions

  def top_related_gems
    GemObject
      .where(gem_category: gem_category)
      .order(downloads: :desc)
      .limit(10)
  end

  def github_uri
    gh_uri = source_code_uri || homepage_uri
    gh_uri &.include?('github.com') ? gh_uri : nil
  end

  def read_readme
    Base64.decode64(readme).force_encoding('UTF-8')
  end

  def html_readme
    return nil if readme.nil?

    markdown = Redcarpet::Markdown.new(::HTML.new(link_attributes: { target: '_blank' }),
                                       autolink: true,
                                       fenced_code_blocks: true,
                                       lax_spacing: true)
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
    parameterized_name = name.present? ? name.parameterize.dasherize : name
    [
      parameterized_name,
      [parameterized_name, "gem"]
    ]
  end

end
