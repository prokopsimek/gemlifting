class ApplicationController < ActionController::Base
  include DevelopmentSecurity, Rescuable

  protect_from_forgery with: :exception

  def home
    @categories = GemCategory.parental.order(:name)
  end

  def robots
    robots_content = ''
    unless Environment.current?('production')
      robots_content += "User-agent: *\n"
      robots_content += "Disallow: /\n"
    end
    robots_content += "Sitemap: https://www.gemlifting.com/sitemap.xml"

    render plain: robots_content, layout: false
  end
end
