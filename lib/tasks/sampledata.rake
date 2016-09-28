namespace :sampledata do
  task create_sample_gem_categories: :environment do
    unless Environment.current?('production')
      20.times do |t|
        name = FFaker::Skill.specialty
        description = "Any description of Category #{t + 1}"
        parent = GemCategory.where(description: description).first_or_create(
          name: name,
          description: description,
          parent_id: nil
        )

        10.times do |tt|
          sname = FFaker::Skill.specialty
          sdescription = "Any description of Subcategory #{tt + 1} - parent of this category is #{parent.name}"
          GemCategory.where(description: sdescription).first_or_create(
            name: sname,
            description: sdescription,
            parent: parent
          )
        end
      end
    end
  end
end
