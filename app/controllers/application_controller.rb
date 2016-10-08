class ApplicationController < ActionController::Base
  include DevelopmentSecurity, Rescuable

  protect_from_forgery with: :exception

  # GET /
  def home
    @categories = GemCategory.parental.eager_load(:subcategories).order(:name)
  end

  # GET /search?q=:query
  def search
    query = params[:q]

    # redirect :back if query is blank
    begin
      redirect_to :back and return if query.blank?
    rescue ActionController::RedirectBackError
      redirect_to root_path and return
    end

    # pretty url for search
    redirect_to search_path(q: query) if params[:utf8]

    @gem_objects = GemObject.search(query)

    @page_title = "Search \"#{query}\""
    @page_description = "Search results for text \"#{query}\""
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
