require 'rails_helper'

RSpec.describe GemObjectInGemCategory, type: :model do
  describe '#create' do
    it 'should create gem_object <> gem_category relation' do
      gem = create(:gem_object)
      gem_subcategory = create(:gem_subcategory)
      gem_object_in_gem_category = build(:gem_object_in_gem_category, gem_object: gem, gem_category: gem_subcategory)

      expect(gem_object_in_gem_category.valid?).to be true
    end

    it 'should not be valid if adding gem to parental category' do
      gem = create(:gem_object)
      gem_category = create(:gem_category)
      gem_object_in_gem_category = build(:gem_object_in_gem_category, gem_object: gem, gem_category: gem_category)

      expect(gem_object_in_gem_category.valid?).to be false
      expect(gem_object_in_gem_category.errors.full_messages.size).to eq 1
      expect(gem_object_in_gem_category.errors.full_messages).to include 'Gem object cannot be in parental category'
    end

    it 'should not be valid if adding gem to subcategory second time' do
      gem = create(:gem_object)
      gem_subcategory = create(:gem_subcategory)
      create(:gem_object_in_gem_category, gem_object: gem, gem_category: gem_subcategory)
      gem_object_in_gem_category = build(:gem_object_in_gem_category, gem_object: gem, gem_category: gem_subcategory)

      expect(gem_object_in_gem_category.valid?).to be false
      expect(gem_object_in_gem_category.errors.full_messages.size).to eq 2
      expect(gem_object_in_gem_category.errors.full_messages).to include 'Gem object has already been taken'
      expect(gem_object_in_gem_category.errors.full_messages).to include 'Gem object can have only 1 category'
    end
  end
end
