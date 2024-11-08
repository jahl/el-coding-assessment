class GameEvent < ApplicationRecord
  extend Enumerize
  enumerize :event_type, in: [:completed]

  validates :event_type, presence: true
  validates :occurred_at, presence: true

  belongs_to :game
  belongs_to :user

  scope :completed, -> { where(event_type: :completed) }
end
