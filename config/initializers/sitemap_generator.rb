SITEMAP_HOST = "http://#{ENV['FOG_DIRECTORY']}.s3.amazonaws.com".freeze
SITEMAP_PATH = "#{Environment.env_tag}/sitemaps".freeze
SITEMAP_URL = "#{SITEMAP_HOST}/#{SITEMAP_PATH}/sitemap.xml".freeze
