require 'rails_helper'

RSpec.describe GemVersion, type: :model do
  describe '#create' do
    it 'should validate version' do
      gem_version = GemVersion.new

      expect(gem_version.valid?).to be true
    end

    it 'should be valid version with gem object' do
      gem_object = build(:gem_object)
      gem_version = build(:gem_version, gem_object: gem_object)

      expect(gem_version.valid?).to be true
    end
  end
end
