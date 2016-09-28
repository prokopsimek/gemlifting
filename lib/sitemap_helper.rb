# lib/sitemap_helper.rb
# this library generates all lang alternatives to sitemap.xml

module SitemapHelper
  extend ActiveSupport::Concern
  include Rails.application.routes.url_helpers
end
