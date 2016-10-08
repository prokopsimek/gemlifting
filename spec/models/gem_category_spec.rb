require 'rails_helper'

RSpec.describe GemCategory, type: :model do
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
end
