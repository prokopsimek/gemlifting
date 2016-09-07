class GemImporter

  attr_reader :name, :gem_object

  def initialize(name)
    @name = name.to_s
    @gem_object = GemObject.find_by(name: @name)
  end

  def self.gems_list
    @gem_list ||= GemRepo.new.names
  end

  def self.import_gems(limit = nil)
    gems_list = self.gems_list
    gems_list = gems_list.first(limit) if limit.present?
    gems_list.each do |gem_name|
      new(gem_name).import
    end
  end

  def import
    gem_info = Gems.info(name)

    gem_obj = GemObject.find_or_initialize_by(name: gem_info['name'])

    gem_obj.assign_attributes(
      name: gem_info['name'],
      downloads: gem_info['downloads'],
      version: gem_info['version'],
      version_downloads: gem_info['version_downloads'],
      authors: gem_info['authors'],
      platform: gem_info['platform'],
      info: gem_info['info'],
      licenses: gem_info['licenses'],
      sha: gem_info['sha'],
      project_uri: gem_info['project_uri'],
      gem_uri: gem_info['gem_uri'],
      homepage_uri: gem_info['homepage_uri'],
      wiki_uri: gem_info['wiki_uri'],
      documentation_uri: gem_info['documentation_uri'],
      mailing_list_uri: gem_info['mailing_list_uri'],
      source_code_uri: gem_info['source_code_uri'] || gem_info['homepage_uri'],
      bug_tracker_uri: gem_info['bug_tracker_uri']
    )

    gem_obj.versions = get_versions_for(gem_obj)

    gem_obj.save!
  end

  private

  def get_versions_for(gem_object)
    gem_versions = Gems.versions(gem_object.name)
    versions_of_gem_object = []

    gem_versions.each do |version_hash|
      gem_version = GemVersion.find_or_initialize_by(gem_object_id: gem_object.id, number: version_hash['number'])

      gem_version.assign_attributes(
        authors: version_hash['authors'],
        built_at: version_hash['built_at'],
        created_at: version_hash['created_at'],
        description: version_hash['description'],
        downloads_count: version_hash['downloads_count'],
        number: version_hash['number'],
        summary: version_hash['summary'],
        platfrom: version_hash['platfrom'],
        rubygems_version: version_hash['rubygems_version'],
        ruby_version: version_hash['ruby_version'],
        prerelease: version_hash['prerelease'],
        licenses: version_hash['licenses'],
        sha: version_hash['sha']

      )

      versions_of_gem_object << gem_version
    end

    versions_of_gem_object
  end

end
