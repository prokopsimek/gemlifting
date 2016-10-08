require 'rails_helper'

RSpec.describe GemCategory, type: :model do
  describe '#create' do
    it 'should build valid category with factory' do
      gem_category = build(:gem_category)

      expect(gem_category.valid?).to be true
    end

    it 'should build valid subcategory with factory' do
      gem_category = build(:gem_category)
      gem_subcategory = build(:gem_category, name: 'Subcategory 1', parent: gem_category)

      expect(gem_category.valid?).to be true
      expect(gem_subcategory.valid?).to be true
    end

    it 'should have filled name' do
      gem_category = GemCategory.new

      expect(gem_category.valid?).to be false
      expect(gem_category.errors.size).to eq 1
      expect(gem_category.errors.full_messages).to include 'Name can\'t be blank'
    end

    it 'should have uniq name' do
      create(:gem_category)
      gem_category2 = build(:gem_category)
      expect(gem_category2.valid?).to be false
      expect(gem_category2.errors.size).to eq 1
      expect(gem_category2.errors.full_messages).to include 'Name has already been taken'
    end
  end
end
