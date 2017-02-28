namespace :sampledata do
  task create_gem_categories: :environment do
    unless Environment.current?('production')
      categories_hash.each do |category_name, subcategories|
        parent = GemCategory.where(name: category_name).first_or_create!
        subcategories.each do |subcategory_name|
          GemCategory.where(name: subcategory_name, parent: parent).first_or_create!
        end
      end
    end
  end

  task add_gems_to_categories: :environment do
    children_categories = GemCategory.all
    gem_objects = GemObject.without_category
    gems_count_for_one_category = gem_objects.count / children_categories.count
    children_categories.each do |gem_category|
      gem_objects.limit(gems_count_for_one_category).each do |gem_object|
        gem_object.update!(gem_category: gem_category)
      end
    end
  end

  task parse_keywords: :environment do
    raise 'no, you cannot' if Environment.current?('production')

    GemObject.where.not(description: nil).find_each do |gem_object|
      blacklist = Highscore::Blacklist.load %w(create app etc way from the and that add not see about using some something under our run you want for will are with end new this use all but can your just get very data out first they second ruby rails gem gems in find)
      text = Highscore::Content.new gem_object.description, blacklist
      text.configure { set :ignore_case, true; }
      resolved_kwds = text
                 .keywords
                 .top(50)
                 .reject { |kwd| t = ActiveSupport::Inflector.transliterate(kwd.to_s); t !~ /^([[:alnum:]]|\-|\_)+$/ && kwd.to_s.downcase.singularize.dasherize.in?(blacklist.words) }
                 .first(5)
                 .collect { |t| t.to_s.singularize.dasherize }
      ap resolved_kwds.join(', ').to_s
      # TODO: gem_object.tags << resolved_kwds
    end
  end
end

def categories_hash
  {
    'Analytics' => [],
    'API Builder' => [],
    'Assets' => ['CSS', 'JavaScript'],
    'Background Processing' => ['Background Jobs', 'Scheduling'],
    'Caching' => [],
    'Code Analysis and Metrics' => [],
    'Communication' => ['CRM', 'Email', 'IRC', 'Messaging'],
    'Concurrency' => [],
    'Configuration' => [],
    'Content Management' => ['Admin Interface', 'CMS', 'Dashboards', 'Static Site Generation'],
    'Core Extensions' => ['Hash', 'Attributes'],
    'Database' => ['Drivers', 'Tools'],
    'Data Visualization' => [],
    'Date and Time' => [],
    'Debugging' => [],
    'Developer Tools' => ['Benchmarking', 'CLI Builder', 'CLI Utilities', 'IRB', 'Git Tools', 'GUI', 'Package Management'],
    'Documentation' => [],
    'E-Commerce and Payments' => [],
    'Enumerators' => [],
    'Environment Management' => [],
    'Files' => ['Upload', 'Processing'],
    'Forms' => ['Builders', 'Nested Forms'],
    'Geolocation' => [],
    'HTTP' => [],
    'Image Processing' => [],
    'I18n' => [],
    'Markdown Processors' => [],
    'Misc' => [],
    'Mobile Development' => [],
    'Monitoring' => ['Error Handling', 'Logging'],
    'Navigation' => [],
    'ORM/ODM' => [],
    'ORM/ODM Extensions' => ['Misc', 'Import', 'Pagination', 'Sorting', 'Validation', 'Multi-tenancy', 'Tree', 'Social', 'Auditing'],
    'Parsers' => ['HTML/XML Parsing'],
    'Plugins' => ['State Machines'],
    'Processes and Threads' => [],
    'Rails Application Generators' => [],
    'RSS' => [],
    'Search' => [],
    'Security' => ['Authentication', 'Authorization', 'Captcha', 'Encryption'],
    'SEO' => [],
    'Services and Apps' => [],
    'Social Networking' => [],
    'Template Engine' => [],
    'Testing' => ['A/B Testing', 'Extra', 'WebDrivers', 'Fake Data', 'Mock', 'Frameworks'],
    'Third-party APIs' => [],
    'User Agent Detection' => [],
    'Video' => [],
    'Web Crawling' => [],
    'Web Frameworks' => [],
    'Web Servers' => [],
    'WebSocket' => [],
  }
end
