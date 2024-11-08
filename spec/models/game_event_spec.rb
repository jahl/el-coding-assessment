require 'rails_helper'

RSpec.describe GameEvent, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:event_type) }
    it { should validate_presence_of(:occurred_at) }
  end

  describe 'relationships' do
    it { should belong_to(:game) }
    it { should belong_to(:user) }
  end

  describe 'scopes' do
    describe '#completed' do
      let!(:game_events) { create_list(:game_event, 5, event_type: :completed) }

      it 'returns only the completed game events' do
        expect(GameEvent.completed.count).to eq(game_events.count)
      end
    end
  end
end
