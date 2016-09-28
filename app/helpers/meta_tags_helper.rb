module MetaTagsHelper
  def set_and_display_meta_tags
    # This template is used because of multilingual sitemap (https://webmasters.googleblog.com/2012/05/multilingual-and-multinational-site.html)
    # This helper sets default values for SEO tags - it is possible to override them
    #   in controller or view (read more: https://github.com/kpumuk/meta-tags#seo-basics-and-metatags)
    display_meta_tags(
      site: 'Gemlifting.com',
      reverse: true,
      keywords: %w(gem rubygem rubygems ruby rails toolbox catalog category categories tools resources services developer github popularity compare gems plugins overview activesupport activerecord actionmailer rack rake bundler mysql i18n),
      description: @page_description || 'asdf',
      og:
        {
          title: :title,
          description: :description,
          site_name: 'Gemlifting.com',
          image: (@page_image_url || image_url('logo.png')).to_s,
          url: request.url.to_s,
          type: 'product'
        },
      twitter:
        {
          card: "summary",
          url: "#{request.url}#",
          title: :title,
          description: :description,
          image: (@page_image_url || image_url('logo.png')).to_s,
          site: "@gemlifting"
        }
    )
  end

  def set_and_display_google_structural_data(data)
    content_tag :script, type: 'application/ld+json' do
      data.to_s
    end
  end

  def generate_search_structured_data
    result_json = {
      "@context": 'https://schema.org',
      '@type': 'WebSite',
      'url': 'https://www.gemlifting.com',
      'potentialAction': {
        '@type': 'SearchAction',
        'target': 'https://www.gemlifting.com/?query={search_term_string}',
        'query-input': 'required name=search_term_string'
      }
    }
    result_json.to_json.html_safe
  end

  def generate_website_structured_data
    result_json = {
      '@context': 'https://schema.org',
      '@type': 'WebSite',
      'name': 'Gemlifting.com',
      'alternateName': 'Gemlifting.com',
      'url': 'https://www.gemlifting.com'
    }
    result_json.to_json.html_safe
  end
end
