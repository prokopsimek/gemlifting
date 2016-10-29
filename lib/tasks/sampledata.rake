namespace :sampledata do
  task create_sample_gem_categories: :environment do
    raise 'no, you cannot' if Environment.current?('production')

    10.times do |t|
      retry_count = 0

      begin
        name = FFaker::Skill.specialty
        description = "Any description of Category #{t + 1}"
        parent = GemCategory.where(description: description).first_or_create!(
          name: name,
          description: description,
          parent_id: nil
        )
      rescue => e
        retry_count += 1
        ap e.to_s
        ap "Retry no.: #{retry_count}"
        retry if retry_count < 10
      end

      10.times do |tt|
        sretry_count = 0

        begin
          sname = FFaker::Skill.specialty
          sdescription = "Any description of Subcategory #{tt + 1} - parent of this category is #{parent.name}"
          GemCategory.where(description: sdescription).first_or_create!(
            name: sname,
            description: sdescription,
            parent: parent
          )
        rescue => e
          sretry_count += 1
          ap e.to_s
          ap "Retry no.: #{sretry_count}"
          retry if sretry_count < 10
        end
      end
    end
  end

  task add_gems_to_categories: :environment do
    raise 'no, you cannot' if Environment.current?('production')

    children_categories = GemCategory.children
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
