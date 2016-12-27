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
