class User < ApplicationRecord
  include JtiTokenizable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  before_create :set_jti

  has_many :game_events

  def total_games_played
    game_events.completed.count
  end
end
