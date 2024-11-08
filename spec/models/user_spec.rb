require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'after_create' do
    let(:user) { build(:user) }

    it 'sets the JTI value automatically' do
      expect(user.jti).to eq(nil)
      user.save!

      expect(user.jti).not_to eq(nil)
    end
  end
end
