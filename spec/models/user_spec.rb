require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'relationships' do
    it { should have_many(:game_events) }
  end

  describe 'after_create' do
    let(:user) { build(:user) }

    it 'sets the JTI value automatically' do
      expect(user.jti).to eq(nil)
      user.save!

      expect(user.jti).not_to eq(nil)
    end
  end

  describe '#total_game_events' do
    let!(:user) { create(:user, :with_game_events, game_events_count: 5) }

    it 'returns the total game events with the type :completed' do
      expect(user.total_games_played).to eq(user.game_events.where(event_type: 'completed').count)
    end
  end
end
