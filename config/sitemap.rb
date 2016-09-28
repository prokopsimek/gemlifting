### Logic of generating the sitemap
require Rails.root.join('lib/sitemap_helper.rb')
SitemapGenerator::Interpreter.send :include, SitemapHelper

# for Heroku must set AWS adapter
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://#{Environment.env_tag}.gemlifting.com"

# pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = 'tmp/'

# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host = SITEMAP_HOST
# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = SITEMAP_PATH

SitemapGenerator::Sitemap.create(compress: false) do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
  #
  # Regenerate sitemap.xml file with command: rake sitemap:refresh

  # add root_path, changefreq: 'monthly'

  GemCategory.find_each do |gem_category|
    add gem_category_path(gem_category),
        priority: 0.6,
        lastmod: gem_category.updated_at,
        changefreq: 'weekly'
  end

  GemObject.find_each do |gem_object|
    add gem_object_path(gem_object),
        priority: 0.8,
        lastmod: gem_object.lastmod_at,
        changefreq: 'weekly'
  end

end

SitemapGenerator::Sitemap.ping_search_engines if Environment.current?('production')
