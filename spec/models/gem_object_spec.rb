require 'rails_helper'

RSpec.describe GemObject, type: :model do
  describe '#create' do
    it 'should validate blank object' do
      gem = GemObject.new
      expect(gem.valid?).to eq false

      errors = gem.errors.full_messages

      expect(errors.size).to eq 1
      expect(errors).to include('Name can\'t be blank')
    end

    it 'should validate factory object' do
      gem = build(:gem_object)
      expect(gem.valid?).to eq true
    end
  end

  describe '#lastmod_at' do
    it 'should take updated_at attribute as first' do
      updated_at_value = DateTime.civil(2016, 10, 8)
      gem = build(:gem_object, updated_at: updated_at_value)
      expect(gem.lastmod_at).to eq updated_at_value
    end

    it 'should take updated_at attribute as first if others are older' do
      updated_at_value = DateTime.civil(2016, 10, 8)
      github_sync_at_value = DateTime.civil(2016, 10, 7)
      rubygems_sync_at_value = DateTime.civil(2016, 10, 6)
      gem = build(:gem_object, updated_at: updated_at_value, github_sync_at: github_sync_at_value, rubygems_sync_at: rubygems_sync_at_value)
      expect(gem.lastmod_at).to eq updated_at_value
    end

    it 'should take github_sync_at if newest than upated_at attribute' do
      updated_at_value = DateTime.civil(2016, 10, 8)
      github_sync_at_value = DateTime.civil(2016, 10, 10)
      gem = build(:gem_object, updated_at: updated_at_value, github_sync_at: github_sync_at_value)
      expect(gem.lastmod_at).to eq github_sync_at_value
    end

    it 'should take rubygems_sync_at if newest than upated_at attribute' do
      updated_at_value = DateTime.civil(2016, 10, 8)
      github_sync_at_value = DateTime.civil(2016, 10, 10)
      rubygems_sync_at_value = DateTime.civil(2016, 10, 22)
      gem = build(:gem_object, updated_at: updated_at_value, github_sync_at: github_sync_at_value, rubygems_sync_at: rubygems_sync_at_value)
      expect(gem.lastmod_at).to eq rubygems_sync_at_value
    end
  end

  describe '#github_uri' do
    it 'should take source_code_uri as first if set both' do
      gem = build(:gem_object, source_code_uri: 'http://first.github.com', homepage_uri: 'http://second.github.com')
      expect(gem.github_uri).to eq 'http://first.github.com'
    end

    it 'should take source_code_uri as first if set both' do
      gem = build(:gem_object, source_code_uri: nil, homepage_uri: 'http://second.github.com')
      expect(gem.github_uri).to eq 'http://second.github.com'
    end

    it 'should return nil if no url with word "github"' do
      gem = build(:gem_object, source_code_uri: 'http://first.anysource.com', homepage_uri: 'http://second.anysource.com')
      expect(gem.github_uri).to eq nil
    end
  end

  describe '#read_readme' do
    it 'should read attr read_readme' do
      readme_value = Base64.encode64('any readme')
      gem = build(:gem_object, readme: readme_value)
      expect(gem.read_readme).to eq 'any readme'
    end
  end

  describe '#html_readme' do
    it 'should read html_readme from markdown with links with target=_blank' do
      readme_value = Base64.encode64('This site was built using [GitHub Pages](https://pages.github.com/).')
      gem = build(:gem_object, readme: readme_value)
      expect(gem.html_readme).to include '<p>This site was built using <a href="https://pages.github.com/" target="_blank">GitHub Pages</a>.</p>'
    end
  end

  describe '#search' do
    it 'should search gems correctly with search weights' do
      GemObject.__elasticsearch__.create_index! force: true

      gem = create(:gem_object, name: 'Any name', description: 'Any description with text asdfghjkl.')
      gem2 = create(:gem_object, name: 'asdfghjkl', description: 'Any description.')

      GemObject.__elasticsearch__.refresh_index!
      search_results = GemObject.search('asdfghjkl')

      records = search_results.records.records
      expect(search_results.results.total).to eq 2
      expect(records.first).to eq gem
      expect(records.second).to eq gem2
    end
  end

  describe 'add to category' do
    xit 'should raise error if trying to add gem into parental category' do
      gem = create(:gem_object)
      parental_category = create(:gem_category)

      expect do
        gem.update!(gem_category: parental_category)
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Cannot add gem into parental category')
    end

    it 'should add gem into subcategory' do
      gem = create(:gem_object)
      parental_category = create(:gem_category)
      category = create(:gem_category, name: 'Subcategory 1', parent: parental_category)

      gem.update!(gem_category: category)
    end
  end
end
