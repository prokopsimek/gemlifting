require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    it 'should validate new user' do
      user = User.new

      expect(user.valid?).to be false
      expect(user.errors.size).to eq 2
      expect(user.errors.full_messages).to include 'Email can\'t be blank'
      expect(user.errors.full_messages).to include 'Password can\'t be blank'
    end
  end
end
